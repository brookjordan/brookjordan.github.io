import { html } from "../helpers/html.js";
import { isHTMLSelectElement } from "../helpers/isHTMLSelectElement.js";

/**
 * @param {Object} params
 * @param {string} params.label
 * @param {string} params.value
 * @param {string[]} params.options
 * @param {string} params.placeholder
 * @param {(newValue: string | null) => void} params.onChange
 */
function Select({ label, value, options, placeholder, onChange }) {
  /**
   * @param {Event} event
   */
  const handleChange = (event) => {
    event.preventDefault();

    if (!isHTMLSelectElement(event.target)) return;

    onChange(event.target.value);
  };

  return html`
    <label class="text-input">
      <select onChange=${handleChange}>
        <option value=${null} disabled>${placeholder}</option>
        ${options.map(
          (option) =>
            html`<option
              key=${option}
              selected=${value === option}
              value=${option}
            >
              ${option}
            </option>`,
        )}
      </select>
      <span>${label}</span>
    </label>
  `;
}

export default Select;
