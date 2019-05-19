import {
  buildTemplate,
  attachTemplate,
} from './helpers/attach-shadow-dom.js';

const TEMPLATE = buildTemplate(/*html*/`
  <style>
    h1 {
      color: red;
    }
  </style>

  <h1>
    <slot name="header">
      [OVERRIDE ME: header]
    </slot>
  </h1>
`);

class BoilerPlateElement extends HTMLElement {
  constructor() {
    super();
    attachTemplate(this, TEMPLATE);
    // all code goes under here
  }

  //connectedCallback() {
  //  when inserting into the DOM
  //}

  //disconnectedCallback() {
  //  when removing from the DOM
  //}

  //attributeChangedCallback(name, oldVal, newVal) {
  //  any time observed attributes change
  //}

  //adoptedCallback() {
  //  each time the custom element is moved to a new document
  //}
}

window.customElements.define('boiler-plate', BoilerPlateElement);

/*
 * Available elements to extend:
 *   HTMLElement
 *   HTMLAnchorElement
 *   HTMLAreaElement
 *   HTMLAudioElement
 *   HTMLBaseElement
 *   HTMLBodyElement
 *   HTMLBRElement
 *   HTMLButtonElement
 *   HTMLCanvasElement
 *   HTMLContentElement
 *   HTMLDataElement
 *   HTMLDataListElement
 *   HTMLDetailsElement
 *   HTMLDialogElement
 *   HTMLDirectoryElement
 *   HTMLDivElement
 *   HTMLDListElement
 *   HTMLEmbedElement
 *   HTMLFieldSetElement
 *   HTMLFontElement
 *   HTMLFormElement
 *   HTMLFrameElement
 *   HTMLFrameSetElement
 *   HTMLHeadElement
 *   HTMLHeadingElement
 *   HTMLHRElement
 *   HTMLHtmlElement
 *   HTMLIFrameElement
 *   HTMLImageElement
 *   HTMLInputElement
 *   HTMLLabelElement
 *   HTMLLegendElement
 *   HTMLLIElement
 *   HTMLLinkElement
 *   HTMLMapElement
 *   HTMLMarqueeElement
 *   HTMLMediaElement
 *   HTMLMenuElement
 *   HTMLMetaElement
 *   HTMLMeterElement
 *   HTMLModElement
 *   HTMLObjectElement
 *   HTMLOListElement
 *   HTMLOptGroupElement
 *   HTMLOptionElement
 *   HTMLOutputElement
 *   HTMLParagraphElement
 *   HTMLParamElement
 *   HTMLPictureElement
 *   HTMLPreElement
 *   HTMLProgressElement
 *   HTMLQuoteElement
 *   HTMLScriptElement
 *   HTMLSelectElement
 *   HTMLShadowElement
 *   HTMLSlotElement
 *   HTMLSourceElement
 *   HTMLSpanElement
 *   HTMLStyleElement
 *   HTMLTableCaptionElement
 *   HTMLTableCellElement
 *   HTMLTableColElement
 *   HTMLTableElement
 *   HTMLTableRowElement
 *   HTMLTableSectionElement
 *   HTMLTemplateElement
 *   HTMLTextAreaElement
 *   HTMLTimeElement
 *   HTMLTitleElement
 *   HTMLTrackElement
 *   HTMLUListElement
 *   HTMLUnknownElement
 *   HTMLVideoElement
 */
