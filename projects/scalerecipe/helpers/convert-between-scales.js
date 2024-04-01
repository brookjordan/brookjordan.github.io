/**
 * @typedef {import('../helpers/scale.js').Scale} Scale
 *
 * @typedef {number} Multiplier
 * @typedef {number} Offset
 *
 * @typedef {Object.<Scale, [Multiplier, Offset]>} ScaleConversions
 */

/**
 * @type {Object.<Scale, ScaleConversions>}
 */
const weightConversions = {
  kg: {
    kg: { multiplier: 1, offset: 0 },
    g: { multiplier: 1000, offset: 0 },
    tsp: { multiplier: 5000, offset: 0 },
    tbsp: { multiplier: 15000, offset: 0 },
    mg: { multiplier: 1000000, offset: 0 },
    lb: { multiplier: 2.20462262, offset: 0 },
    oz: { multiplier: 35.27396195, offset: 0 },
    cup: { multiplier: 4.40924524375, offset: 0 },
  },
  g: {
    kg: { multiplier: 0.001, offset: 0 },
    g: { multiplier: 1, offset: 0 },
    tsp: { multiplier: 5, offset: 0 },
    tbsp: { multiplier: 15, offset: 0 },
    mg: { multiplier: 1000, offset: 0 },
    lb: { multiplier: 0.0022046226, offset: 0 },
    oz: { multiplier: 0.035273961, offset: 0 },
    cup: { multiplier: 0.004409245125, offset: 0 },
  },
  tsp: {
    kg: { multiplier: 0.0002, offset: 0 },
    g: { multiplier: 0.2, offset: 0 },
    tsp: { multiplier: 1, offset: 0 },
    tbsp: { multiplier: 3, offset: 0 },
    mg: { multiplier: 200, offset: 0 },
    lb: { multiplier: 0.00044092452, offset: 0 },
    oz: { multiplier: 0.0070547922, offset: 0 },
    cup: { multiplier: 0.000881849025, offset: 0 },
  },
  tbsp: {
    kg: { multiplier: 0.00006666666666666667, offset: 0 },
    g: { multiplier: 0.06666666666666667, offset: 0 },
    tsp: { multiplier: 0.3333333333333333, offset: 0 },
    tbsp: { multiplier: 1, offset: 0 },
    mg: { multiplier: 66.66666666666667, offset: 0 },
    lb: { multiplier: 0.00014697484, offset: 0 },
    oz: { multiplier: 0.0023515974, offset: 0 },
    cup: { multiplier: 0.000293949675, offset: 0 },
  },
  mg: {
    kg: { multiplier: 0.000001, offset: 0 },
    g: { multiplier: 0.001, offset: 0 },
    tsp: { multiplier: 0.005, offset: 0 },
    tbsp: { multiplier: 0.015, offset: 0 },
    mg: { multiplier: 1, offset: 0 },
    lb: { multiplier: 0.0000022046226, offset: 0 },
    oz: { multiplier: 0.000035273961, offset: 0 },
    cup: { multiplier: 0.000004409245125, offset: 0 },
  },
  lb: {
    kg: { multiplier: 0.45359237, offset: 0 },
    g: { multiplier: 453.59237038, offset: 0 },
    tsp: { multiplier: 2267.9618519, offset: 0 },
    tbsp: { multiplier: 6803.8855557, offset: 0 },
    mg: { multiplier: 453592.37038038, offset: 0 },
    lb: { multiplier: 1, offset: 0 },
    oz: { multiplier: 16.00000001, offset: 0 },
    cup: { multiplier: 2.0, offset: 0 },
  },
  oz: {
    kg: { multiplier: 0.028349523, offset: 0 },
    g: { multiplier: 28.34952312, offset: 0 },
    tsp: { multiplier: 141.74761560000002, offset: 0 },
    tbsp: { multiplier: 425.2428468, offset: 0 },
    mg: { multiplier: 28349.52312466, offset: 0 },
    lb: { multiplier: 0.0625, offset: 0 },
    oz: { multiplier: 1, offset: 0 },
    cup: { multiplier: 0.125, offset: 0 },
  },
  cup: {
    kg: { multiplier: 0.22679618, offset: 0 },
    g: { multiplier: 226.79618496, offset: 0 },
    tsp: { multiplier: 1133.9809248000001, offset: 0 },
    tbsp: { multiplier: 3401.9427744, offset: 0 },
    mg: { multiplier: 226796.18499728, offset: 0 },
    lb: { multiplier: 0.5, offset: 0 },
    oz: { multiplier: 8, offset: 0 },
    cup: { multiplier: 1, offset: 0 },
  },

  centigrade: {
    centigrade: { multiplier: 1, offset: 0 },
    fahrenheit: { multiplier: 1.8, offset: 32 },
    kelvin: { multiplier: 1, offset: 273.15 },
  },
  fahrenheit: {
    centigrade: { multiplier: 0.55555556, offset: -17.77777777 },
    fahrenheit: { multiplier: 1, offset: 0 },
    kelvin: { multiplier: 0.55555556, offset: 255.37222222 },
  },
};

// /**
//  * @type {Ingredient[]}
//  */
// const quantities = [
//   { value: 105, scale: "g", altScale: "", label: "all-purpose flour" },
//   { value: 2, scale: "g", altScale: "", label: "baking soda" },
//   { value: 0.5, scale: "g", altScale: "", label: "salt" },
//   { value: 1, scale: "g", altScale: "", label: "teaspoon ground cinnamon" },
//   { value: 50, scale: "g", altScale: "", label: "unsalted butter" },
//   { value: 60, scale: "g", altScale: "", label: "brown sugar" },
//   { value: 45, scale: "g", altScale: "", label: " large eggs" },
//   { value: 35, scale: "g", altScale: "", label: "yogurt or sour cream" },
//   { value: 190, scale: "g", altScale: "~4", label: "bananas" },
//   { value: 2, scale: "g", altScale: "", label: "vanilla" },
//   { value: 40, scale: "g", altScale: "", label: "chopped pecans / walnuts" },
// ];

/**
 * @param {number} value
 * @param {Scale} from
 * @param {Scale} to
 */
export const convertBetweenScales = (value, from, to) => {
  const conversion = weightConversions[from][to];

  return value * conversion.multiplier + conversion.offset;
};
