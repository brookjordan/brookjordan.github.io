import { isHTMLInputElement } from "../helpers/isHTMLInputElement.js";
import { html } from "../helpers/html.js";
import { useId } from "preact/hooks";

/**
 * @param {Object} params
 * @param {string} params.label
 * @param {string} params.value
 * @param {string} params.placeholder
 * @param {(newValue: string | null) => void} params.onInput
 * @param {string} params.type
 * @param {string[]} [params.datalist]
 */
function TextInput({ label, value, placeholder, onInput, type, datalist }) {
  const datalistId = useId();
  /**
   * @param {Event} event
   */
  const handleInput = (event) => {
    event.preventDefault();

    if (!isHTMLInputElement(event.target)) return;

    onInput(event.target.value);
  };

  return html`
    <label class="text-input">
      <input
        type=${type || "text"}
        value=${value}
        onInput=${handleInput}
        placeholder=${placeholder}
        list=${datalistId ? datalistId : undefined}
      />
      <span>${label}</span>
    </label>

    ${datalist &&
    html`<datalist id=${datalistId}>
      ${datalist.map((option) => html`<option value=${option}></option>`)}
    </datalist>`}
  `;
}

export default TextInput;
