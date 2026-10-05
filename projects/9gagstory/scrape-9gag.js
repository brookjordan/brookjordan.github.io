import posts250 from './0-250-cposts.js';
import posts500 from './250-500-cposts.js';
import posts750 from './500-750-cposts.js';
import posts100 from './750-1000-cposts.js';

let allPosts = [
  ...posts250,
  ...posts500,
  ...posts750,
  ...posts100,
];

function uniq(array, { logEvery = 1000, minDist = 50 } = {}) {
  let iters = 0;
  let prevArrLength;
  let arrLength;
  let newArr = array;
  let startTime = Date.now();

  do {
    let prevPrint = 0;
    prevArrLength = newArr.length;
    newArr = newArr.filter((item, index, arr) => {
      if (index % logEvery === 0) {
        let print = Date.now() - startTime;
        console.log(`${index} - ${((print - prevPrint) / 60000).toFixed(2)} - ${(print / 60000).toFixed(2)}`);
        prevPrint = print;
      }
      return arr.indexOf(item) == index || arr.indexOf(item) < index - minDist;
    });
    arrLength = newArr.length;
    console.log(`After ${++iters} filters, the length is ${arrLength}`);
  } while (arrLength < prevArrLength);

  return newArr;
}

console.log(`loaded data, starting to flatten ${allPosts.length} post comments`);
let allPostTexts = allPosts
  .flatMap(p => [
    p.title,
    ...uniq(p.comments.flatMap(p => [
      p.text,
      ...p.replies.flatMap(r => [
        r.text,
        ...r.replies.map(rr => rr.text)
      ])
    ]), { logEvery: 50000, minDist: 500 })
  ]);

console.log(`finished data gathering, cleaning ${allPostTexts.length} texts`);
console.log(allPostTexts.filter(a => a.trim()).map(a => a.trim()).join('\n\n'));
