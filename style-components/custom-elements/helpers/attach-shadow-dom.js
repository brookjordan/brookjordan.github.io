export function buildTemplate(templateString) {
  const TEMPLATE_ELEMENT = document.createElement('template');
  TEMPLATE_ELEMENT.innerHTML = templateString;
  return TEMPLATE_ELEMENT;
}

export function attachTemplate(element, templateElement) {
  return element
    .attachShadow({
      mode: 'open',
    })
    .appendChild(templateElement.content.cloneNode(true))
}
