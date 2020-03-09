const ROOT_ELEMENT = document.documentElement;

export default function(name, value, element) {
  (element || ROOT_ELEMENT).style.setProperty(
    `--${name}`,
    value
  );
}

export function setGlobalCSSCustomProperty(name, value) {
  ROOT_ELEMENT.style.setProperty(
    `--${name}`,
    value
  );
}
