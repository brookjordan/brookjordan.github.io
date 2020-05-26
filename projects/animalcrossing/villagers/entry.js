const chars = require("./chars.js");
const download = require("./download.js");

(async function() {
  let c = chars.slice(0);
  let promises = [];
  while (c.length) {
    let cc = c.shift();
    if (!cc[1]) { console.log(cc); continue; }
    promises.push(
      download(cc[1], cc[0], cc[1].split('.')[cc[1].split('.').length - 1])
      .then(() => console.log(cc[0]))
    );
  }
  await Promise.all(promises);
  console.log("done.");
}());
