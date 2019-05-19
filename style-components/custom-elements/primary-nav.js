import {
  buildTemplate,
  attachTemplate,
} from './helpers/attach-shadow-dom.js';

const TEMPLATE = buildTemplate(/*html*/`
  <style>
    :host {
      display: contents;
    }

    nav {
      display: flex;
    }

    .row {
      flex-direction: row;
    }

    .column {
      flex-direction: column;
      width: 240px;
    }

    ::slotted(*) {
      align-self: center;
    }

    ::slotted(h3),
    ::slotted(a) {
      align-self: stretch;
      display: flex;
      align-items: center;
      font-family: "Open Sans", sans-serif;
    }

    ::slotted(h3) {
      font-family: "Proxima Nova", sans-serif;
      font-size: 17px;
      font-weight: 700;
    }

    ::slotted(a) {
      border: 0 solid transparent;
      line-height: 20px;
      background-color: rgb(0 0 0 / 0);
      color: #6C7279;
      font-size: 14px;
      font-weight: 400;
      text-decoration: none;
      transition: background-color 0.5s;
    }

    ::slotted(a:hover) {
      background-color: rgb(0 0 0 / 0.04);
    }

    ::slotted(.active) {
      color: #47841F;
      border-color: currentColor;
    }

    .row ::slotted(*) {
      margin-top: 5px;
    }

    .row ::slotted(h3),
    .row ::slotted(a) {
      margin-top: 0;
      min-height: 54px;
      padding: 4px 0;
      padding-top: 10px;
    }

    .row ::slotted(a) {
      margin-left: calc(var(--side-margin) / 2);
      margin-right: calc(var(--side-margin) / 2);
      border-bottom-width: 3px;
    }

    .column ::slotted(h3),
    .column ::slotted(a) {
      padding: 4px var(--side-margin);
      border-right-width: 3px;
      min-height: 44px;
    }

    .column ::slotted(h3) {
      margin: 0;
      margin-top: 30px;
    }
  </style>

  <nav>
    <slot class="slot">
      [SLOT: nav]
    </slot>
  </nav>
`);

const DIRECTIONS = [
  'row',
  'column',
];

class PrimaryNavElement extends HTMLElement {
  constructor() {
    super();
    this.DOM = attachTemplate(this, TEMPLATE);
    this.nav = this.shadowRoot.querySelector('nav');
  }

  connectedCallback() {
    this.updateDirection(this.getAttribute('direction'));
    this.updateActive();
    window.addEventListener('hashchange', e => { this.updateActive(); });
  }

  attributeChangedCallback(name, oldVal, newVal) {
    if (name === 'direction') {
      this.updateDirection(newVal);
    }
  }

  updateDirection(newDirection = DIRECTIONS[0]) {
    this.nav.className = DIRECTIONS.includes(newDirection)
      ? newDirection
      : DIRECTIONS[0];
  }

  updateActive() {
    Array.from(this.querySelectorAll('a')).forEach(a => {
      if (a.href === location.href) {
        a.classList.add('active');
      } else {
        a.classList.remove('active');
      }
    });
  }
}

window.customElements.define('primary-nav', PrimaryNavElement);
