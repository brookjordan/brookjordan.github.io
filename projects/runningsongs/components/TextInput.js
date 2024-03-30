import { isHTMLInputElement } from "../helpers/isHTMLInputElement.js";
import { html } from "../helpers/html.js";

/**
 * @param {Object} params
 * @param {string} params.label
 * @param {string} params.value
 * @param {string} params.placeholder
 * @param {(newValue: string | null) => void} params.onInput
 * @param {string} params.type
 */
function TextInput({ label, value, placeholder, onInput, type }) {
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
      />
      <span>${label}</span>
    </label>
  `;
}

export default TextInput;
