import { html } from "../helpers/html.js";
import { units } from "./App.js";
import NumberInput from "./NumberInput.js";
import TextInput from "./TextInput.js";
import Select from "./Select.js";

/**
 * @typedef {import("../helpers/convert-between-scales.js").Scale} Scale
 */

const FOOD = ["Rice", "White sugar", "White flour"];

/**
 * @param {Object} props
 * @param {number} props.index
 * @param {string} props.label
 * @param {(value: string) => void} props.onLabelChange
 * @param {number} props.weightValue
 * @param {(value: number) => void} props.onWeightValueChange
 * @param {Scale} props.scale
 * @param {(value: Scale) => void} props.onScaleChange
 * @param {number} props.stockedAmount
 * @param {(value: number) => void} props.onStockedAmountChange
 * @param {() => void} props.onRemoveClick
 * @param {boolean} props.cannotRemove
 */
function IngredientComponent({
  index,
  label,
  onLabelChange,
  weightValue,
  onWeightValueChange,
  scale,
  onScaleChange,
  stockedAmount,
  onStockedAmountChange,
  onRemoveClick,
  cannotRemove,
}) {
  return html`
    <div style="margin-bottom: 10px">
      <${TextInput}
        label="Name"
        value=${label}
        onInput=${onLabelChange}
        placeholder=${`Ingredient ${index + 1}`}
        datalist=${FOOD}
      />

      <${NumberInput}
        label="Value"
        value=${weightValue}
        onInput=${onWeightValueChange}
      />

      <${Select}
        label="Scale"
        value=${scale}
        options=${units}
        placeholder="Select a scale"
        onChange=${onScaleChange}
      />

      <${NumberInput}
        label="Stocked"
        value=${stockedAmount}
        onInput=${onStockedAmountChange}
        placeholder="enough"
      />

      ${!cannotRemove &&
      html`<button onClick=${onRemoveClick} type="button">×</button>`}
    </div>
  `;
}

export default IngredientComponent;
