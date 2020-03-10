import getPokemon from "../pokemon.js";

let css = /*css*/`
  @keyframes fade-in {
    0% {
      opacity: 0;
      transform: scale(1);
    }
    100% {
      opacity: 1;
      transform: scale(1.5);
    }
  }

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
    animation: fade-in ease-out 100ms;
    opacity: 1;
    transform:
      translateY(-5px)
      scale(1.5)
    ;
  }

  .grid {
    display: grid;
    grid-template-columns: repeat(3, calc(100% / 3));
    transition:
      opacity 150ms ease-in;
  }
  .grid > div {
    padding: 50%;
  }
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
  <div class="grid" id="grid"></div>
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
      this.pokemon = null;
      this.imageElt = null;
      this.imageEltAddEvent = null;
    }

    async connectedCallback() {
      await this.definePokemon();
      this.connectedCallbackCalled = true;
    }

    async attributeChangedCallback(name, oldValue, newValue) {
      if (this.connectedCallbackCalled) {
        if (oldValue !== newValue) {
          this.definePokemon();
        }
      }
    }

    async definePokemon() {
      if (this.pokemon) { return; }

      let nameAttr = this.getAttribute("name");

      if (!nameAttr) { throw "required-attr-error: Missing name attribute"; }
      this.pokemon = (await getPokemon()).find(aPokemon => aPokemon.name.toLowerCase() === nameAttr.toLowerCase());
      if (!this.pokemon) { throw `missing-pokemon-error: No pokémon exists with the name ${nameAttr}`; }

      let colorElts = this.pokemon.colors
        .map(rgb => {
          let colorElt = document.createElement("div");
          if (rgb) {
            colorElt.style.backgroundColor = `rgb(${rgb})`;
          }
          return colorElt;
        });
      this.gridElt.append(...colorElts);

      this.nameElt.textContent = this.pokemon.name;

      if (this.imageElt) {
        this.imageElt.remove();
        this.gridElt.removeEventListener("mouseenter", this.imageEltAddEvent, { once: true });
      }
      this.imageElt = new Image();
      this.imageEltAddEvent = e => {
        this.imageElt.src = this.pokemon.imageSrc;
        this.imageElt.onload = () => {
          this.shadowRoot.insertBefore(this.imageElt, this.gridElt);
        };
      };
      this.gridElt.addEventListener("mouseenter", this.imageEltAddEvent, { once: true });
    }
  },
);
