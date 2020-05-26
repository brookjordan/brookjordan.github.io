const fs = require('fs')
const request = require('request')
const path = require('path')

module.exports = function(url, name, ext) {
  return new Promise((resolve, reject) => {
    request.head(url, (err, res, body) => {
      if (err) {
        reject(err);
        return;
      }
      request(url)
        .pipe(fs.createWriteStream(path.join(__dirname, "i", `${name}.${ext}`)))
        .on('close', () => {
          resolve();
        })
    })
  })
}
