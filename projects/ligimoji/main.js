'use strict';

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

var parts = ['body', 'eyes', 'mouth'];

var emojis = {
  default: {
    body: 'round',
    eyes: 'normal',
    mouth: 'normal'
  },
  '🙂': {
    eyes: 'normal',
    mouth: 'normal'
  },
  '😍': {
    eyes: 'hearts',
    mouth: 'giggle'
  },
  '🍆': {
    body: 'egg-plant'
  }
};

var fromInputElt = document.getElementById('emoji-from');
var testEmoji = document.getElementById('test-emoji');
addClass();
fromInputElt.addEventListener('change', addClass);
fromInputElt.addEventListener('mouseup', addClass);
fromInputElt.addEventListener('click', addClass);
fromInputElt.addEventListener('mousedown', addClass);
fromInputElt.addEventListener('keyup', addClass);

function addClass() {
  testEmoji.className = 'emoji ' + getClassName.apply(undefined, _toConsumableArray(emojiStringToArray(fromInputElt.value.trim())));
}

function getClassName() {
  var makeup = Object.assign({}, emojis.default);
  var j = 0; // index of part being checked

  for (var _len = arguments.length, ligs = Array(_len), _key = 0; _key < _len; _key++) {
    ligs[_key] = arguments[_key];
  }

  for (var i = 0, l = ligs.length; i < l; i += 1) {
    var emoji = emojis[ligs[i]];

    while (j <= parts.length && !emoji[parts[j]]) {
      j += 1;
    }

    for (var _l = parts.length; j < _l; j += 1) {
      var partName = parts[j];
      if (emoji[partName]) {
        makeup[partName] = emoji[partName];
        if (ligs.length > i + 1) {
          console.log('break');
          break;
        }
      }
    }
    j += 1;
  }

  return parts.map(function (part) {
    return 'emoji--' + part + '-' + makeup[part];
  }).join(' ');
}

function emojiStringToArray(str) {
  var split = str.split(/([\uD800-\uDBFF][\uDC00-\uDFFF])/);
  var arr = [];
  for (var i = 0, l = split.length; i < l; i++) {
    var char = split[i];
    if (char !== "") {
      arr.push(char);
    }
  }
  return arr;
};
