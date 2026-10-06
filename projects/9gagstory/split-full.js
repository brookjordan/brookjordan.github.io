const path = require('path');
const fs = require('fs');

const FILE_NAME = 'sentence-starters.json';
const DESTINATION_FOLDER = 'sentence-starters';
const FILE_SIZE = 14400000;
const DESIRED_SIZE = 400000;

fs.readFile( path.join(__dirname, FILE_NAME), function (err, data) {
  if (err) {
    throw err;
  }
  console.log("Loaded data");

  let lines = data.toString().split('\n');

  console.log("Split data");

  let batchSize = Math.ceil(lines.length / (FILE_SIZE / DESIRED_SIZE));
  let batchCount = Math.ceil(lines.length / batchSize);

  let batchNumber = 1;
  while (lines.length) {
    let thisBatchNumber = batchNumber++;
    console.log(`Writing: ${path.join(__dirname, DESTINATION_FOLDER, `batch-${thisBatchNumber}-${batchCount}.js`)}`);
    let batch = lines.splice(0, Math.min(batchSize, lines.length)).join('');
    fs.writeFile(
      path.join(
        __dirname,
        DESTINATION_FOLDER,
        `batch-${thisBatchNumber}-${batchCount}.js`
      ),
      `export default \`${batch}\``,
      (err) => {
        if (err) throw err;
        console.log(`Wrote: ${path.join(__dirname, DESTINATION_FOLDER, `batch-${thisBatchNumber}-${batchCount}.js`)}`);
      }
    );
  }
});
