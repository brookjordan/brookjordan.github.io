const ALL_HELPERS = {
  getLength,
};


export default ALL_HELPERS;


export function getLength(coordA,
                          coordB) {
  return Math.sqrt(Math.pow(coordA[0] - coordB[0], 2) + Math.pow(coordA[1] - coordB[1], 2));
}
