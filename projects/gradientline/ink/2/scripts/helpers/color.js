let colorHelpers = {
  hex2rgb,
  randomHexColor,
};

export default hex2rgb;

export function hex2rgb(hexValue) {
  return /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hexValue);
}

export function randomHexColor() {
  return '#000000'.replace(/0/g, () => (~~(Math.random()*16)).toString(16));
}
