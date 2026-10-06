const fs = require('fs');

console.log("loading texts");
const text = require("./all-text.js");

const combos = {};
const words = text.split(" ");
const currentCombo = words.slice(0, 4);

let comboName;
let word;
let set;

for (let i = 4, l = words.length; i < l; i += 1) {
  word = words[i].trim();

  if (i % 50000 === 0) {
    console.log(`building combo ${i} of ${l}`);
  }

  if (!word || /^[-:\.\/]+$/.test(word)) {
    continue;
  }

  if (/\d+/.test(word)) {
    word = "_NUM_";
  }

  comboName = currentCombo.join(" ");
  combos[comboName] || (combos[comboName] = {});
  set = combos[comboName];
  set[word] || (set[word] = 0);
  set[word] += 1;

  comboName = currentCombo.slice(-3).join(" ");
  combos[comboName] || (combos[comboName] = {});
  set = combos[comboName];
  set[word] || (set[word] = 0);
  set[word] += 1;

  comboName = currentCombo.slice(-2).join(" ");
  combos[comboName] || (combos[comboName] = {});
  set = combos[comboName];
  set[word] || (set[word] = 0);
  set[word] += 1;

  comboName = currentCombo.slice(-1).join(" ");
  combos[comboName] || (combos[comboName] = {});
  set = combos[comboName];
  set[word] || (set[word] = 0);
  set[word] += 1;

  currentCombo.push(word);
  currentCombo.shift();
}

Object.values(combos).forEach((entries) => entries._TTL_ = Object.values(entries).reduce(((sum, val) => sum + val), 0));

fs.writeFile('combos.js', `module.exports = JSON.parse(\`${JSON.stringify(combos, null, 1)}\`)`, (err) => {
  if (err) throw err;
  console.log('The file has been saved!');
});
