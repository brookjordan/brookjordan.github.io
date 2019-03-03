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
  },
  '😂': {
    eyes: 'scrunched-tears',
    mouth: 'laugh'
  },
  '😀': {
    mouth: 'laugh'
  },
  '😆': {
    eyes: 'scrunched',
    mouth: 'laugh'
  },
  '😁': {
    eyes: 'blink-happy',
    mouth: 'laugh'
  },
  '😗': {
    mouth: 'pucker'
  },
  '😙': {
    eyes: 'blink-happy',
    mouth: 'pucker'
  },
  '😘': {
    eyes: 'wink-happy',
    mouth: 'pucker-heart'
  }
};

var workingInputElt = document.getElementById('working-emoji');
var fromInputElt = document.getElementById('emoji-from');
var testEmoji = document.getElementById('test-emoji');

addSupportedEmoji();
addInitialClass();

fromInputElt.addEventListener('change', addClass);
fromInputElt.addEventListener('mouseup', addClass);
fromInputElt.addEventListener('click', addClass);
fromInputElt.addEventListener('mousedown', addClass);
fromInputElt.addEventListener('keyup', addClass);

function addSupportedEmoji() {
  Object.keys(emojis).forEach(function (emoji) {
    if (emoji !== 'default') {
      workingInputElt.value += emoji;
    }
  });
}

function addInitialClass() {
  if (/[\&\?]str=[^&$]/.test(location.search)) {
    fromInputElt.value = decodeURI(/[\&\?]str=([^\&$]+)/.exec(location.search)[1]);
  }
  addClass();
}

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
          break;
        }
      }
    }
    j += 1;
  }

  var newLocation = void 0;
  if (/[\&\?]str=/.test(location.search)) {
    newLocation = location.href.replace(/(\?|&)str=[^\&$]*/, '$1str=' + ligs.join(''));
  } else if (location.search.indexOf('?') > -1) {
    newLocation = location.href + '&str=' + ligs.join('');
  } else {
    newLocation = location.href + '?str=' + ligs.join('');
  }
  window.history.replaceState({}, "", newLocation);

  return parts.map(function (part) {
    return 'emoji--' + part + '-' + makeup[part];
  }).join(' ');
}

function emojiStringToArray(str) {
  return str.match(/(?:[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff]|[\u0023-\u0039]\ufe0f?\u20e3|\u3299|\u3297|\u303d|\u3030|\u24c2|\ud83c[\udd70-\udd71]|\ud83c[\udd7e-\udd7f]|\ud83c\udd8e|\ud83c[\udd91-\udd9a]|\ud83c[\udde6-\uddff]|[\ud83c[\ude01-\ude02]|\ud83c\ude1a|\ud83c\ude2f|[\ud83c[\ude32-\ude3a]|[\ud83c[\ude50-\ude51]|\u203c|\u2049|[\u25aa-\u25ab]|\u25b6|\u25c0|[\u25fb-\u25fe]|\u00a9|\u00ae|\u2122|\u2139|\ud83c\udc04|[\u2600-\u26FF]|\u2b05|\u2b06|\u2b07|\u2b1b|\u2b1c|\u2b50|\u2b55|\u231a|\u231b|\u2328|\u23cf|[\u23e9-\u23f3]|[\u23f8-\u23fa]|\ud83c\udccf|\u2934|\u2935|[\u2190-\u21ff])/g);
};
