import {
  buildTemplate,
  attachTemplate,
} from './helpers/attach-shadow-dom.js';

const TEMPLATE = buildTemplate(/*html*/`
  <style>
    :host {
      display: grid;
      grid-template-areas:
        "header header"
        "aside main"
        "footer footer";
      grid-template-rows: auto 1fr auto;
      grid-template-columns: auto 1fr;
    }

    header {
      grid-area: header;
      padding: 0 var(--side-margin);
      background-color: #f4f4f5;
      overflow: hidden;
    }

    header ::slotted(*) {
      align-items: center;
    }

    header ::slotted([space-between]) {
      display: flex;
      justify-content: space-between;
    }

    aside {
      grid-area: aside;
      overflow: hidden;
    }

    main {
      grid-area: main;
      overflow: hidden;
    }

    footer {
      grid-area: footer;
      overflow: hidden;
    }
  </style>

  <header>
    <slot name="header">
      [SLOT: header]
    </slot>
  </header>

  <aside>
    <slot name="aside">
      [SLOT: aside]
    </slot>
  </aside>

  <main>
    <slot name="main">
      [SLOT: main]
    </slot>
  </main>

  <footer>
    <slot name="footer">
      [SLOT: footer]
    </slot>
  </footer>
`);

class DesignSystemPageElement extends HTMLElement {
  constructor() {
    super();
    attachTemplate(this, TEMPLATE);
  }
}

window.customElements.define('design-system-page', DesignSystemPageElement);
