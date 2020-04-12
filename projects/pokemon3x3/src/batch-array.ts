export default function(array, batchSize) {
  let batchedArray = [];
  for (let i = 0; i < array.length; i += batchSize) {
    batchedArray.push(array.slice(i, i + batchSize));
  }
  return batchedArray;
}
