import { isHTMLInputElement } from "../helpers/isHTMLInputElement.js";
import { html } from "../helpers/html.js";
import { useEffect, useState } from "preact/hooks";

/**
 * @param {Object} params
 * @param {string} params.label
 * @param {number} params.value
 * @param {string} params.placeholder
 * @param {(newValue: number | null) => void} params.onInput
 */
function NumberInput({ label, value, placeholder, onInput }) {
  const [displayValue, setDisplayValue] = useState(
    isNaN(value) ? "" : String(value),
  );

  useEffect(() => {
    value === null ? setDisplayValue("") : setDisplayValue(String(value));
  }, [value]);

  /**
   * @param {Event} event
   */
  const handleInput = (event) => {
    event.preventDefault();

    if (!isHTMLInputElement(event.target)) return;

    setDisplayValue(event.target.value);
    onInput(event.target.valueAsNumber);
  };

  return html`
    <label class="text-input">
      <input
        type="number"
        value=${displayValue}
        onInput=${handleInput}
        placeholder=${placeholder}
        step="0.0000001"
      />
      <span>${label}</span>
    </label>
  `;
}

export default NumberInput;
