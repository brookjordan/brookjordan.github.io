import { useMemo, useState } from "preact/hooks";
import { html } from "../helpers/html.js";
import { Ingredient } from "../helpers/ingredient.js";
import IngredientComponent from "./IngredientComponent.js";
import { isHTMLSelectElement } from "../helpers/isHTMLSelectElement.js";
import Select from "./Select.js";

/**
 * @typedef {import("../helpers/ingredient.js").Conversion} Conversion
 * @typedef {import("../helpers/convert-between-scales.js").Scale} Scale
 */

/** @type {Scale[]} */
export const units = ["kg", "g", "tsp", "tbsp", "mg", "lb", "oz", "cup"];

/**
 * @param {number | null} stockedValue
 * @param {Scale} outputUnit
 * @param {number} requiredValue
 * @param {Scale} requiredUnit
 * @returns
 */
const getConversion = (
  outputUnit,
  stockedValue,
  requiredValue,
  requiredUnit,
) =>
  stockedValue
    ? {
        from: {
          value: requiredValue,
          scale: requiredUnit,
        },
        to: {
          value: stockedValue,
          scale: outputUnit,
        },
      }
    : outputUnit;

function App() {
  const [outputScale, setOutputScale] = useState(/** @type {Scale} */ ("g"));

  const [ingredients, setIngredients] = useState([
    {
      label: "",
      weightValue: 0,
      scale: /** @type {Scale} */ ("g"),
      stockedAmount: /** @type {number | null} */ (null),
    },
  ]);
  const ingredientClasses = useMemo(() => {
    const stockedIngredient = ingredients.find(
      (ingredient) => ingredient.stockedAmount !== null,
    );
    const conversion = getConversion(
      outputScale,
      stockedIngredient?.stockedAmount,
      stockedIngredient?.weightValue,
      stockedIngredient?.scale,
    );

    return ingredients.map((ingredient) => {
      const newIngredient = new Ingredient({
        label: ingredient.label,
        weight: {
          value: ingredient.weightValue,
          scale: ingredient.scale,
        },
      });

      newIngredient.conversion = conversion;
      return newIngredient;
    });
  }, [ingredients, outputScale]);

  /**
   * @param {number} index
   * @returns {(newValue: string) => void}
   */
  const handleLabelChange = (index) => (newValue) => {
    setIngredients((prevIngredients) => {
      const newIngredients = [...prevIngredients];
      newIngredients[index].label = newValue;

      return newIngredients;
    });
  };

  /**
   * @param {number} index
   * @returns {(newValue: Scale) => void}
   */
  const handleScaleChange = (index) => (newValue) => {
    setIngredients((prevIngredients) => {
      const newIngredients = [...prevIngredients];
      newIngredients[index].scale = newValue;

      return newIngredients;
    });
  };

  /**
   * @param {number} index
   * @returns {(newValue: number) => void}
   */
  const handleWeightValueChange = (index) => (newValue) => {
    setIngredients((prevIngredients) => {
      const newIngredients = [...prevIngredients];
      newIngredients[index].weightValue = newValue;

      return newIngredients;
    });
  };

  /**
   * @param {number} index
   * @returns {(newValue: number) => void}
   */
  const handleStockedAmountChange = (index) => (newValue) => {
    setIngredients((prevIngredients) => {
      const newIngredients = prevIngredients.map((ingredient) => ({
        ...ingredient,
        stockedAmount: /** @type {number | null} */ (null),
      }));
      newIngredients[index].stockedAmount = newValue;

      return newIngredients;
    });
  };

  /**
   * @param {number} index
   * @returns {() => void}
   */
  const handleRemoveClick = (index) => () => {
    setIngredients((prevIngredients) => {
      const newIngredients = [...prevIngredients];
      newIngredients.splice(index, 1);

      return newIngredients;
    });
  };

  const handleAddIngredientClick = () => {
    setIngredients((prevIngredients) => [
      ...prevIngredients,
      {
        label: "",
        weightValue: 0,
        scale: /** @type {Scale} */ (ingredients.at(-1).scale),
        stockedAmount: /** @type {number | null} */ (null),
      },
    ]);
  };

  return html`
    <p>Ingredients:</p>
    <div>
      ${ingredients.map(
        (ingredient, index) =>
          html`<${IngredientComponent}
            index=${index}
            label=${ingredient.label}
            onLabelChange=${handleLabelChange(index)}
            scale=${ingredient.scale}
            onScaleChange=${handleScaleChange(index)}
            weightValue=${ingredient.weightValue}
            onWeightValueChange=${handleWeightValueChange(index)}
            stockedAmount=${ingredient.stockedAmount || null}
            onStockedAmountChange=${handleStockedAmountChange(index)}
            onRemoveClick=${handleRemoveClick(index)}
            cannotRemove=${ingredients.length === 1}
          />`,
      )}
      <button onClick=${handleAddIngredientClick} type="button">
        Add ingredient
      </button>
    </div>

    <hr style="border-top: 1px solid black; margin: 10px" />

    <p>Output scale:</p>
    <${Select}
      label="Output scale"
      value=${outputScale}
      options=${units}
      placeholder="Select an output scale"
      onChange=${setOutputScale}
    />

    <hr style="border-top: 1px solid black; margin: 10px" />

    <p>Result:</p>
    <ul>
      ${ingredientClasses.map(
        (ingredientClass, index) =>
          html`<li>
            ${ingredientClass.label || `Ingredient ${index + 1}`}:${" "}
            ${ingredientClass.weight?.value.toLocaleString()}${" "}
            ${ingredientClass.weight?.scale}
          </li>`,
      )}
    </ul>
  `;
}

export default App;
