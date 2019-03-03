const importElt = document.querySelector('.main-menu__button--import');
const exportElt = document.querySelector('.main-menu__button--export');
let DEFAULT_IMPORT = new Array(512)
  .fill(DEADCHARS[VERSION])
  .join('');

importElt.addEventListener('click', e => {
  const string = prompt('Gimme the data', DEFAULT_IMPORT);

  if (string) {
    setData(
      string,
      prompt('What version?', VERSION),
      {
        overrideExisting: confirm('Want me to overwite your data with the new data?'),
      }
    );
  }
});

exportElt.addEventListener('click', e => {
  prompt("This is version ${VERSION}. Here's your data:", getData());
});
