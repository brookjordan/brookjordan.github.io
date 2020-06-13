import combos1 from './combos-string-1-4.js';
import combos2 from './combos-string-2-4.js';
import combos3 from './combos-string-3-4.js';
import combos4 from './combos-string-4-4.js';

console.log('Loaded. Parsing…');
const combos = JSON.parse(combos1 + combos2 + combos3 + combos4);

const p = document.querySelector("p");
const button = document.querySelector("button");

console.log('Building logic…');
const comboKeys = Object.keys(combos);
const comboCount = comboKeys.length;

let sentence = comboKeys[Math.floor(Math.random() * comboCount)];
const words = sentence.split(' ');

function addWord() {
  let _words = [...words];
  while (!combos[_words.join(' ')]) {
    _words.shift();
  }
  const data = combos[_words.join(' ')];
  const ttl = data._TTL_;
  delete data._TTL_;

  let entries = Object.entries(data);
  let rnd = Math.random() * ttl;
  let culm = 0;
  let i = -1;
  do {
    culm += entries[++i][1];
  } while (culm < rnd);
  sentence += ` ${entries[i][0]}`;
  words.push(entries[i][0]);
  if (words.length > 4) {
    words.shift();
  }
}

button.onclick = async () => {
  console.log('Writing words…');

  button.style.pointerEvents = "none";
  button.style.opacity = "0.2";
  for (let i = 0; i < 100; i += 1) {
    await new Promise(_ => setTimeout(_, 100));
    addWord();
    p.textContent = sentence;
  }
  button.style.pointerEvents = "initial";
  button.style.opacity = "1";

  console.log('App ready.');
}

button.onclick();
