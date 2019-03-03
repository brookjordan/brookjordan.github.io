const BROWSER_HAS = {
  INPUT_TYPE_COLOR: browserHasColorInput(),
};

export default BROWSER_HAS;

function browserHasColorInput() {
  var inputelt = document.createElement('input');
  inputelt.setAttribute('type', 'color');
  var hasColorInputType = inputelt.type === 'color' && 'style' in inputelt;

  if (hasColorInputType) {
    inputelt.value         = '1)';
    hasColorInputType = inputelt.value != '1)';
  }

  return !!hasColorInputType;
}
