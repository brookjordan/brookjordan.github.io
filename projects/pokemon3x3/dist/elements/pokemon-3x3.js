import getPokemon from "../pokemon.js";
import connection from "../connection-details.js";
;
;
let css = /*css*/ `
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
    pointer-events: none;
    transition:
      opacity 100ms ease-in,
      transform 100ms ease-in;
  }
  img,
  :host([reveal]:hover) img {
    opacity: 0;
    transform:
      translateY(-5px)
      scale(1)
    ;
  }
  :host([reveal]) img {
    display: block;
  }
  :host([reveal]) img {
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
  :host([reveal]) img + .grid {
    opacity: 0.3;
  }
  :host([reveal]:hover) img + .grid {
    opacity: 1;
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
    background: rgba(0,0,0,0.7);
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

  form {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: scale(0) translate(-50%, -50%);
    opacity: 0;
    transition: opacity 0.2s, transform 0.2s;
  }
  :host([guessing]) form {
    transform: scale(1) translate(-50%, -50%);
    opacity: 1;
  }
  [list="pokemon-list"] {
    font-size: 20px;
    font-size: min(26px, max(20px, 4vmin));
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
  <form>
    <input list="pokemon-list">
    <button style="display:none"></button>
    <datalist id="pokemon-list"></datalist>
  </form>
  <h3 class="name" id="name"></h3>
`;
export class Pokemon3x3 extends HTMLElement {
    constructor() {
        super();
        this.connectedCallbackCalled = false;
        this.attachShadow({ mode: "open" });
        this.shadowRoot.appendChild(pokemon3x3Template.content.cloneNode(true));
        this.guessForm = this.shadowRoot.querySelector('form');
        this.guessInput = this.shadowRoot.querySelector('[list="pokemon-list"]');
        this.gridElt = this.shadowRoot.querySelector("#grid");
        this.nameElt = this.shadowRoot.querySelector("#name");
        this.pokemonListElt = this.shadowRoot.querySelector("#pokemon-list");
        this.colorElts = Array.from(this.shadowRoot.querySelectorAll("#grid > div"));
        if (!this.guessInput) {
            console.log(this.guessInput);
        }
        this.guessListeners = [];
        this.pokemon = null;
        this.imageElt = null;
    }
    handleGridMouseEnter() { }
    ;
    static get observedAttributes() {
        return [
            "name",
            "reveal",
            "guessing",
        ];
    }
    addEventListener(eventName, callback, options) {
        if (eventName === "guess") {
            this.guessListeners.push({
                options,
                callback,
            });
        }
        else {
            super.addEventListener(eventName, callback, options);
        }
    }
    ;
    removeEventListener(eventName, callback, options) {
        if (eventName === "guess") {
            throw Error("removeEventListener isn’t supported for guess events yet.");
        }
        else {
            super.removeEventListener(eventName, callback, options);
        }
    }
    ;
    alertCorrectness(event) {
        event.preventDefault();
        this.guessListeners.forEach(guessListener => {
            guessListener.callback({
                guess: this.guessInput.value,
            });
        });
    }
    get guessing() {
        return typeof this.hasAttribute("guessing");
    }
    set guessing(value) {
        if (value == null || value === false) {
            this.removeAttribute("guessing");
        }
        else {
            this.setAttribute("guessing", "");
        }
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
        if (value == null || value === false) {
            this.removeAttribute("reveal");
        }
        else {
            this.setAttribute("reveal", "");
        }
    }
    connectedCallback() {
        this.definePokemon().then(() => {
            this.connectedCallbackCalled = true;
        });
        this.guessForm.onsubmit = this.alertCorrectness.bind(this);
    }
    async attributeChangedCallback(key, oldValue, newValue) {
        if (oldValue !== newValue && this.connectedCallbackCalled) {
            if (key === "reveal") {
                this.addImageElt();
            }
            else if (key === "name") {
                this.definePokemon();
            }
            else if (key === "guessing") {
                if (newValue != null && newValue !== false) {
                    this.guessInput.focus();
                }
            }
        }
    }
    async definePokemon() {
        if (this.pokemon) {
            return;
        }
        if (!this.name) {
            throw "required-attr-error: Missing name attribute";
        }
        let allPokemon = await getPokemon();
        this.pokemon = allPokemon.find(aPokemon => aPokemon.name.toLowerCase() === this.name.toLowerCase());
        if (!this.pokemon) {
            throw `missing-pokemon-error: No pokémon exists with the name ${this.name}`;
        }
        this.colors = await this.pokemon.colors;
        this.colors.forEach((rgb, i) => {
            if (rgb) {
                this.colorElts[i].style.backgroundColor = `rgb(${rgb})`;
            }
            else {
                this.colorElts[i].style.backgroundColor = `transparent`;
            }
        });
        this.nameElt.textContent = this.pokemon.name;
        let pokemonDataListFragment = document.createDocumentFragment();
        allPokemon.forEach(({ name }) => {
            let optionElt = document.createElement("option");
            optionElt.value = name;
            pokemonDataListFragment.append(optionElt);
        });
        this.pokemonListElt.append(pokemonDataListFragment);
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
        if (this.imageElt || !this.reveal) {
            return;
        }
        this.gridElt.removeEventListener("mouseenter", this.handleGridMouseEnter);
        this.gridElt.removeEventListener("touchstart", this.handleGridMouseEnter);
        this.imageElt = new Image();
        if (connection.isStrong) {
            this.imageElt.src = this.pokemon.image.bigSrc;
        }
        else {
            this.imageElt.src = this.pokemon.image.smallSrc;
        }
        this.imageElt.onload = () => {
            this.shadowRoot.insertBefore(this.imageElt, this.gridElt);
        };
    }
}
;
export default window.customElements.define("pokemon-3x3", Pokemon3x3);
//# sourceMappingURL=pokemon-3x3.js.map