import { convertBetweenScales } from "./convert-between-scales.js";
import { reproportionValue } from "./reproportion-value.js";

/**
 * @typedef {import('../helpers/scale.js').Scale} Scale
 *
 * @typedef {Object} Weight
 * @property {number} value
 * @property {Scale} scale
 *
 * @typedef {Object} DetailedConversion
 * @property {Weight} from
 * @property {Weight} to
 * @typedef {DetailedConversion | Scale} Conversion
 *
 * @typedef {Object} IngredientParams
 * @property {Weight} weight
 * @property {string} [label]
 * @property {string} [altScale]
 */

export class Ingredient {
  #weight = /** @type {Weight | undefined} */ (undefined);
  #label = /** @type {string | undefined} */ (undefined);
  #altScale = /** @type {string | undefined} */ (undefined);

  #conversion = /** @type {Conversion | undefined} */ (undefined);

  /**
   * @param {Conversion} newConversion
   */
  set conversion(newConversion) {
    if (!newConversion) {
      this.#conversion = undefined;
      return;
    }

    this.#conversion = newConversion;
  }

  get inputWeight() {
    return this.#weight;
  }

  get weight() {
    if (!this.#weight) {
      return undefined;
    }

    if (!this.#conversion) {
      return this.#weight;
    }

    if (typeof this.#conversion === "string") {
      return {
        value: convertBetweenScales(
          this.#weight.value,
          this.#weight.scale,
          this.#conversion,
        ),
        scale: this.#conversion,
      };
    }

    const convertedWeightValue = convertBetweenScales(
      this.#weight.value,
      this.#weight.scale,
      this.#conversion.to.scale,
    );
    const convertedFromValue = convertBetweenScales(
      this.#conversion.from.value,
      this.#conversion.from.scale,
      this.#weight.scale,
    );
    const convertedToValue = convertBetweenScales(
      this.#conversion.to.value,
      this.#conversion.to.scale,
      this.#weight.scale,
    );

    return {
      value: reproportionValue(
        convertedWeightValue,
        convertedFromValue,
        convertedToValue,
      ),
      scale: this.#conversion.to.scale,
    };
  }

  get localWeight() {
    if (!this.#weight) {
      return undefined;
    }

    if (!this.#conversion || typeof this.#conversion === "string") {
      return this.#weight;
    }

    return {
      value: reproportionValue(
        this.#weight.value,
        this.#conversion.from.value,
        this.#conversion.to.value,
      ),
      scale: this.#weight.scale,
    };
  }

  get label() {
    return this.#label;
  }

  get altScale() {
    return this.#altScale;
  }

  /**
   *
   * @param {IngredientParams} properties
   */
  constructor({ weight, label, altScale }) {
    this.#weight = weight;
    this.#label = label;
    this.#altScale = altScale;
  }
}
