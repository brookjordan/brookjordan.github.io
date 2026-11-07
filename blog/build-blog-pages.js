import path from "path";
import fs from "fs/promises";
import { marked } from "marked";
import markedImages from "marked-images";
import prism from "prismjs";
import { createHash } from "crypto";
import htmlminifier from "html-minifier";
import { dirname } from "path";
import { fileURLToPath } from "url";
import "prismjs/components/prism-typescript.js";

marked.use(markedImages({ fqImages: { route: "/i/", url: "../.." } }));

marked.setOptions({
  highlight: (code, lang) => {
    const log = console.log;
    console.log = () => {};
    const highlightedCode = prism.highlight(code, prism.languages[lang], lang);
    console.log = log;
    return highlightedCode;
  },
});

const { readFile, readdir, mkdir, open, writeFile } = fs;

const __dirname = dirname(fileURLToPath(import.meta.url));

const postContentPlaceholder = "[CONTENT]";
const postLastUpdatedPlaceholder = "[LAST_UPDATED]";
const directoryListingPlaceholder = "[POST_LINKS]";
const directoryPublishedDatePlaceholder = "[POST_PUBDATE]";

const postTemplateStringGetter = readFile(
  path.join(__dirname, "posts", "template.html"),
  "utf8"
);
const postDirectoryTemplateStringGetter = readFile(
  path.join(__dirname, "index_template.html"),
  "utf8"
);
const postFileNamesGetter = readdir(path.join(__dirname, "posts")).then(
  (fileNames) => fileNames.filter((fileName) => fileName.endsWith(".md"))
);

// Each post's dates are pinned in dates.json, so a rebuild on another machine or
// after a fresh clone gives the same dates. File metadata changes whenever files
// are copied, and on 2026-11-07 a rebuild re-dated every old post to the day the
// repository arrived on this laptop. A new post is pinned on its first build; a
// post whose Markdown changes gets today as its "last updated" date.
const datesPath = path.join(__dirname, "dates.json");
const postDatesGetter = (async () => {
  const dates = JSON.parse(await readFile(datesPath, "utf8").catch(() => "{}"));
  let changed = false;
  for (const fileName of await postFileNamesGetter) {
    const postName = fileName.split(".")[0];
    const contents = await readFile(path.join(__dirname, "posts", fileName));
    const sha256 = createHash("sha256").update(contents).digest("hex");
    const entry = dates[postName];
    const today = new Date();
    if (!entry) {
      dates[postName] = { published: today.toISOString(), updated: today.toDateString(), sha256 };
      changed = true;
    } else if (entry.sha256 !== sha256) {
      entry.updated = today.toDateString();
      entry.sha256 = sha256;
      changed = true;
    }
  }
  if (changed) await writeFile(datesPath, JSON.stringify(dates, null, 2) + "\n");
  return dates;
})();

function minifyHTML(html) {
  return htmlminifier.minify(html, {
    removeComments: true,
    removeCommentsFromCDATA: true,
    collapseWhitespace: true,
    collapseBooleanAttributes: true,
    removeAttributeQuotes: true,
    removeRedundantAttributes: true,
    useShortDoctype: true,
    removeEmptyAttributes: true,
    removeOptionalTags: true,
    removeEmptyElements: true,
  });
}

// build posts
async function buildPosts() {
  try {
    const [postTemplateString, postFileNames] = await Promise.all([
      postTemplateStringGetter,
      postFileNamesGetter,
    ]);

    const indexHTMLBuilders = postFileNames.map(async (fileName) => {
      let postName = fileName.split(".")[0];
      let markdownFilePath = path.join(__dirname, "posts", fileName);
      let indexHTMLFileDir = path.join(__dirname, "post", postName);
      let indexHTMLFilePath = path.join(indexHTMLFileDir, "index.html");
      let mdContentsGetter = readFile(markdownFilePath, "utf8");
      let indexHTMLFileDescriptorGetter = (async function () {
        await mkdir(indexHTMLFileDir, { recursive: true });
        return await open(indexHTMLFilePath, "w");
      })();

      let [postDates, mdContents, indexHTMLFileDescriptor] = await Promise.all([
        postDatesGetter,
        mdContentsGetter,
        indexHTMLFileDescriptorGetter,
      ]);
      const dates = postDates[postName];

      let htmlContents = marked.parse(mdContents);
      let indexHTMLFileContents = postTemplateString
        .replace(postLastUpdatedPlaceholder, dates.updated)
        .replace(postContentPlaceholder, htmlContents)
        .replace(
          directoryPublishedDatePlaceholder,
          dates.published
        );
      await writeFile(
        indexHTMLFileDescriptor,
        minifyHTML(indexHTMLFileContents)
      );

      console.log(`Written: ${fileName}`);
    });

    await Promise.all(indexHTMLBuilders);

    console.log(`Finished writing all blog post index.html`);
  } catch (error) {
    console.log("Error while building the blog posts:");
    console.log(error);
  }
}

// build post directory
async function buildPostDirectory() {
  const directoryLinkTemplate = /*html*/ `<div>
    <a href="[LISTING_HREF]">[LISTING_TITLE]</a>
    (<a href="[LISTING_MARKDOWN_HREF]">md</a>)
  </div>`;
  const directoryLinkHrefPlaceholder = "[LISTING_HREF]";
  const directoryMarkdownLinkHrefPlaceholder = "[LISTING_MARKDOWN_HREF]";
  const directoryLinkTitlePlaceholder = "[LISTING_TITLE]";
  try {
    const indexHTMLFilePath = path.join(__dirname, "index.html");
    const [
      postDirectoryTemplateString,
      postFileNames,
      indexHTMLFileDescriptor,
    ] = await Promise.all([
      postDirectoryTemplateStringGetter,
      postFileNamesGetter,
      open(indexHTMLFilePath, "w"),
    ]);

    const files = await Promise.all(
      postFileNames.map(async (postFileName) => {
        let markdownFilePath = path.join(__dirname, "posts", postFileName);
        let postName = postFileName.split(".")[0];
        let [mdContents, postDates] = await Promise.all([
          readFile(markdownFilePath, "utf8"),
          postDatesGetter,
        ]);

        let mdTitle;
        try {
          mdTitle = /(^|\n)# ([^\n]+)/.exec(mdContents)[2];
        } catch (error) {
          console.log(`No title found for "${postName}"`);
          mdTitle = postName;
        }
        const explicitLink = `https://brook.dev/blog/post/${postName}`;
        const link = `./post/${postName}`;
        return {
          date: new Date(postDates[postName].published),
          link: explicitLink,
          title: mdTitle,
          HTML: directoryLinkTemplate
            .replace(directoryLinkHrefPlaceholder, link)
            .replace(directoryLinkTitlePlaceholder, `${mdTitle}`)
            .replace(
              directoryMarkdownLinkHrefPlaceholder,
              `./posts/${postFileName}`
            ),
        };
      })
    );

    const RSSFeed = `<?xml version="1.0"?>
<rss version="2.0">
  <channel>
    <title>Brook’s blog</title>
    <link>https://brook.dev/blog</link>
    <description>Various things Brook did or liked</description>
    <language>en-gb</language>
    <pubDate>${new Date(files.sort((a, b) => +new Date(b.date) - +new Date(a.date))[0].date).toUTCString()}</pubDate>
    <lastBuildDate>${new Date().toUTCString()}</lastBuildDate>
    <managingEditor>brook@brook.dev</managingEditor>
    <webMaster>brook@brook.dev</webMaster>

${files.map((item) =>
`    <item>
      <title>${item.title}</title>
      <link>${item.link}</link>
      <description>${item.title}</description>
      <pubDate>${new Date(item.date).toUTCString()}</pubDate>
      <guid>${item.link}</guid>
    </item>`

).join('\n\n')
}
  </channel>
</rss>`;

    writeFile('./feed.rss', RSSFeed);
    writeFile('./feed', RSSFeed);
    writeFile('./rss', RSSFeed);

    const indexHTMLFileContents = postDirectoryTemplateString.replace(
      directoryListingPlaceholder,
      `<nav>${(
        files
      )
        .sort(({date: aDate}, {date: bDate}) => new Date(bDate) - new Date(aDate))
        .map(({_, HTML}) => HTML)
        .join("")}</nav>`
    );

    await writeFile(indexHTMLFileDescriptor, minifyHTML(indexHTMLFileContents));

    console.log(`Finished writing the blog post directory index.html`);
  } catch (error) {
    console.log("Error while building the blog post directory:");
    console.log(error);
  }
}

buildPosts();
buildPostDirectory();
