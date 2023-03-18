import path from "path";
import fs from "fs/promises";
import { marked } from "marked";
import markedImages from "marked-images";
import prism from "prismjs";
import { fileMetadata } from "file-metadata";
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

      let [mdMeta, mdContents, indexHTMLFileDescriptor] = await Promise.all([
        fileMetadata(markdownFilePath),
        mdContentsGetter,
        indexHTMLFileDescriptorGetter,
      ]);

      let htmlContents = marked.parse(mdContents);
      let indexHTMLFileContents = postTemplateString
        .replace(
          postLastUpdatedPlaceholder,
          `${mdMeta.contentModificationDate}`.split(/ \d+:/)[0]
        )
        .replace(postContentPlaceholder, htmlContents)
        .replace(
          directoryPublishedDatePlaceholder,
          mdMeta.contentCreationDate.toISOString()
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
        let [mdContents, mdMeta] = await Promise.all([
          readFile(markdownFilePath, "utf8"),
          fileMetadata(markdownFilePath),
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
          date: mdMeta.contentCreationDate,
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
    <pubDate>${files.sort((a, b) => +new Date(b.date) - +new Date(a.date))[0].date}</pubDate>
    <lastBuildDate>${String(new Date())}</lastBuildDate>
    <managingEditor>brook@brook.dev</managingEditor>
    <webMaster>brook@brook.dev</webMaster>

${files.map((item) =>
`    <item>
      <title>${item.title}</title>
      <link>${item.link}</link>
      <description>${item.title}</description>
      <pubDate>${item.date}</pubDate>
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
