let m;
let i;

export default function shuffle(array) {
  m = array.length;

  while (m) {
    i = Math.floor(Math.random() * m--);
    [array[i], array[m]] = [array[m], array[i]];
  }

  return array;
}
