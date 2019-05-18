const path = require('path');
const { promisify } = require('util');
const fs = require('fs');
const marked = require('marked');
const fileMetadata = require('file-metadata');
const htmlminifier = require('html-minifier');

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

const [
  readFile,
  readdir,
  mkdir,
  open,
  writeFile,
] = [
  promisify(fs.readFile),
  promisify(fs.readdir),
  promisify(fs.mkdir),
  promisify(fs.open),
  promisify(fs.writeFile),
];

const postContentPlaceholder = '[CONTENT]';
const postLastUpdatedPlaceholder = '[LAST_UPDATED]';
const directoryListingPlaceholder = '[POST_LINKS]';
const directoryPublishedDatePlaceholder = '[POST_PUBDATE]';

const postTemplateStringGetter = readFile(path.join(__dirname, 'posts', 'template.html'), 'utf8');
const postDirectoryTemplateStringGetter = readFile(path.join(__dirname, 'index_template.html'), 'utf8');
const postFileNamesGetter = (readdir(path.join(__dirname, 'posts'))
  .then(fileNames =>
    (fileNames
      .filter(fileName => fileName.endsWith('.md'))
    )
  )
);


// build posts
async function buildPosts() {
  try {
    const [
      postTemplateString,
      postFileNames,
    ] = await Promise.all([
      postTemplateStringGetter,
      postFileNamesGetter,
    ]);

    const indexHTMLBuilders = (postFileNames
      .map(async fileName => {
        let postName = fileName.split('.')[0];
        let markdownFilePath = path.join(__dirname, 'posts', fileName);
        let indexHTMLFileDir = path.join(__dirname, 'post', postName);
        let indexHTMLFilePath = path.join(indexHTMLFileDir, 'index.html');
        let mdContentsGetter = readFile(markdownFilePath, 'utf8');
        let indexHTMLFileDescriptorGetter = (async function (){
          await mkdir(indexHTMLFileDir, { recursive: true });
          return await open(indexHTMLFilePath, 'w');
        }());

        let [
          mdMeta,
          mdContents,
          indexHTMLFileDescriptor,
        ] = await Promise.all([
          fileMetadata(markdownFilePath),
          mdContentsGetter,
          indexHTMLFileDescriptorGetter,
        ]);

        let htmlContents = marked(mdContents);
        let indexHTMLFileContents = (postTemplateString
          .replace(postLastUpdatedPlaceholder, `${mdMeta.contentModificationDate}`.split(/ \d{4} /)[0])
          .replace(postContentPlaceholder, htmlContents)
          .replace(directoryPublishedDatePlaceholder, mdMeta.contentCreationDate.toISOString())
        );
        await writeFile(indexHTMLFileDescriptor, minifyHTML(indexHTMLFileContents));

        console.log(`Written: ${fileName}`);
      })
    );

    await Promise.all(indexHTMLBuilders);

    console.log(`Finished writing all blog post index.html`);
  } catch (error) {
    console.log('Error while building the blog posts:');
    console.log(error);
  }
}


// build post directory
async function buildPostDirectory() {
  const directoryLinkTemplate = /*html*/`<div>
    <a href="[LISTING_HREF]">[LISTING_TITLE]</a>
    (<a href="[LISTING_MARKDOWN_HREF]">md</a>)
  </div>`;
  const directoryLinkHrefPlaceholder = '[LISTING_HREF]';
  const directoryMarkdownLinkHrefPlaceholder = '[LISTING_MARKDOWN_HREF]';
  const directoryLinkTitlePlaceholder = '[LISTING_TITLE]';
  try {
    const indexHTMLFilePath = path.join(__dirname, 'index.html');
    const [
      postDirectoryTemplateString,
      postFileNames,
      indexHTMLFileDescriptor,
    ] = await Promise.all([
      postDirectoryTemplateStringGetter,
      postFileNamesGetter,
      open(indexHTMLFilePath, 'w'),
    ]);

    const indexHTMLFileContents = (postDirectoryTemplateString
      .replace(
        directoryListingPlaceholder,
        `<nav>${
          ((await Promise.all(postFileNames
            .map(async postFileName => {
              let markdownFilePath = path.join(__dirname, 'posts', postFileName);
              let postName = postFileName.split('.')[0];
              let [
                mdContents,
                mdMeta,
              ] = await Promise.all([
                readFile(markdownFilePath, 'utf8'),
                fileMetadata(markdownFilePath),
              ]);

              let mdTitle;
              try {
                mdTitle = /(^|\n)# ([^\n]+)/.exec(mdContents)[2];
              } catch (error) {
                console.log(`No title found for "${postName}"`);
                mdTitle = postName;
              }
              return [
                mdMeta.contentCreationDate,
                (directoryLinkTemplate
                  .replace(directoryLinkHrefPlaceholder, `./post/${postName}`)
                  .replace(directoryLinkTitlePlaceholder, `${mdTitle}`)
                  .replace(directoryMarkdownLinkHrefPlaceholder, `./posts/${postFileName}`)
                ),
              ];
            })
          ))
            .sort(([aDate], [bDate]) => new Date(bDate) - new Date(aDate))
            .map(([,HTML]) => HTML)
            .join('')
          )
        }</nav>`
      )
    );

    await writeFile(indexHTMLFileDescriptor, minifyHTML(indexHTMLFileContents));

    console.log(`Finished writing the blog post directory index.html`);
  } catch (error) {
    console.log('Error while building the blog post directory:');
    console.log(error);
  }
}


buildPosts();
buildPostDirectory();
