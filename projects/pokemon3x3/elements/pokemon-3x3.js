import getPokemon from "../pokemon.js";

let css = /*css*/`
  *,
  ::before,
  ::after {
    box-sizing: border-box;
  }

  :host {
    display: block;
    position: relative;
    font-family: 'VT323', monospace;
  }

  img {
    display: none;
    position: absolute;
    top: 0;
    left: 0;
    z-index: 1;
    width: 100%;
    height: auto;
    opacity: 0;
    transform:
      translateY(-5px)
      scale(1)
    ;
    pointer-events: none;
    transition:
      opacity 100ms ease-in,
      transform 100ms ease-in;
  }
  :host([reveal]) img {
    display: block;
  }
  :host([reveal]:hover) img {
    opacity: 1;
    transform:
      translateY(-5px)
      scale(1.5)
    ;
  }

  .grid {
    --fade: 200ms;
    display: grid;
    grid-template-columns: repeat(3, calc(100% / 3));
    transition:
      opacity 150ms ease-in;
  }
  .grid > div {
    --fade-order: 0;
    padding: 50%;
    background-color: transparent;
    transition: background-color var(--fade) ease-out;
    transition-delay: calc(var(--fade) / 3 * var(--fade-order));
  }
  .grid > div:nth-child(2) { --fade-order: 1; }
  .grid > div:nth-child(3) { --fade-order: 2; }
  .grid > div:nth-child(6) { --fade-order: 3; }
  .grid > div:nth-child(9) { --fade-order: 4; }
  .grid > div:nth-child(8) { --fade-order: 5; }
  .grid > div:nth-child(7) { --fade-order: 6; }
  .grid > div:nth-child(4) { --fade-order: 7; }
  .grid > div:nth-child(5) { --fade-order: 8; }
  :host([reveal]:hover) img + .grid {
    opacity: 0.3;
  }

  .name {
    display: none;
    position: absolute;
    top: calc(100% - 6px);
    left: 50%;
    transform:
      translateX(-50%)
      scale(1)
    ;
    padding: 3px 5px;
    margin: 0;
    background: black;
    color: var(--text-color, white);
    font-size: var(--font-size, 10px);
    line-height: 1;
    font-weight: 100;
    text-align: center;
    opacity: 0;
    transform-origin: 50% 0%;
    transition:
      opacity 150ms,
      transform 200ms
    ;
  }
  :host([reveal]) .name {
    display: block;
  }
  :host([reveal]:hover) .name {
    opacity: 1;
    transform:
      translateX(-50%)
      scale(2)
    ;
  }
`;

let pokemon3x3Template = document.createElement("template");
pokemon3x3Template.innerHTML = `
  <style>${css}</style>
  <div class="grid" id="grid">
    <div></div><div></div><div></div>
    <div></div><div></div><div></div>
    <div></div><div></div><div></div>
  </div>
  <h3 class="name" id="name"></h3>
`;

window.customElements.define("pokemon-3x3",
  class extends HTMLElement {
    static get observedAttributes() {
      return [
        "name",
        "reveal",
      ];
    }

    constructor() {
      super();
      this.attachShadow({ mode: "open" });
      this.shadowRoot.appendChild(pokemon3x3Template.content.cloneNode(true));

      this.gridElt = this.shadowRoot.querySelector("#grid");
      this.nameElt = this.shadowRoot.querySelector("#name");
      this.colorElts = [...this.shadowRoot.querySelectorAll("#grid > div")];

      this.pokemon = null;
      this.imageElt = null;
      this.handleGridMouseEnter = null;
    }

    get name() {
      return this.getAttribute("name");
    }

    set name(value) {
      this.setAttribute("name", value);
    }

    get reveal() {
      return this.hasAttribute("reveal");
    }

    set reveal(value) {
      if (typeof value === "string") {
        this.setAttribute("reveal", value);
      } else {
        this.removeAttribute("reveal");
      }
    }

    connectedCallback() {
      this.definePokemon().then(() => {
        this.connectedCallbackCalled = true;
      });
    }

    async attributeChangedCallback(key, oldValue, newValue) {
      if (oldValue !== newValue && this.connectedCallbackCalled) {
        if (key === "reveal") {
          this.addImageElt();
        }

        else if (key === "name") {
          this.definePokemon();
        }
      }
    }

    async definePokemon() {
      if (this.pokemon) { return; }

      if (!this.name) { throw "required-attr-error: Missing name attribute"; }
      this.pokemon = (await getPokemon()).find(aPokemon => aPokemon.name.toLowerCase() === this.name.toLowerCase());
      if (!this.pokemon) { throw `missing-pokemon-error: No pokémon exists with the name ${this.name}`; }

      this.colors = await this.pokemon.colors;
      this.colors.forEach((rgb, i) => {
          if (rgb) {
            this.colorElts[i].style.backgroundColor = `rgb(${rgb})`;
          } else {
            this.colorElts[i].style.backgroundColor = `transparent`;
          }
        });

      this.nameElt.textContent = this.pokemon.name;

      if (this.imageElt) {
        this.imageElt.remove();
        this.imageElt = null;
        this.gridElt.removeEventListener("mouseenter", this.handleGridMouseEnter);
        this.gridElt.removeEventListener("touchstart", this.handleGridMouseEnter);
      }

      if (this.reveal) {
        this.handleGridMouseEnter = () => this.addImageElt();
        this.gridElt.addEventListener("mouseenter", this.handleGridMouseEnter);
        this.gridElt.addEventListener("touchstart", this.handleGridMouseEnter);
      }
    }

    addImageElt() {
      if (this.imageElt || !this.reveal) { return; }
      this.gridElt.removeEventListener("mouseenter", this.handleGridMouseEnter);
      this.gridElt.removeEventListener("touchstart", this.handleGridMouseEnter);
      this.imageElt = new Image();
      this.imageElt.src = this.pokemon.imageSrc;
      this.imageElt.onload = () => {
        this.shadowRoot.insertBefore(this.imageElt, this.gridElt);
      };
    }
  },
);
