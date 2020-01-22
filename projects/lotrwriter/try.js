var genn    = gen();
var running = false;
var itr     = false;

function attemptGetGen() {
  !running && getGen();
}

function getGen() {
  running = true;

  let _ = genn.next();
  let word = _.value;

  if (needMore()) {
    if (itr) {
      document.body.textContent += ` ${word}`;
    } else {
      itr = true;
      document.body.textContent = word.slice(0,1).toUpperCase() + word.slice(1);
    }
    requestAnimationFrame(getGen);
  } else {
    running = false;
  }
}

function*gen() {
  var uniqueWords     = Object.keys(a).filter(b => b.indexOf(',') === -1);
  var recentWords     = [];
  var story           = [];
  var wordCount       = 1000;
  var ln              = 7;
  var oln             = 0.5 / 7;

  while(true) {
    let word;
    let wordFrequenies;
    let possibleWords;
    let culmulative = 0;
    let rnd  = Math.random();
    let rnd2 = Math.random();
    let ln2 = ln;
    let i = 1;

    if (rnd2 < 0.5) {
      while (rnd2 > 0.5 + oln * i) {
        i   += 1;
        ln2 -= 1;
      }
    }

    if (recentWords.length) {
      if (ln2 === 1) {
        //recentWords = [];
        word = uniqueWords[Math.floor(Math.random() * uniqueWords.length)];
      } else {
        do {
          wordFrequenies = a[recentWords.slice(-3).join()]
        } while (typeof wordFrequenies === 'undefined');
      }

      if (wordFrequenies) {
        Object.keys(wordFrequenies).forEach(w => {
          culmulative += wordFrequenies[w];
          if (!word && culmulative > rnd) {
            word = w;
          }
        });
      }
    } else {
      word = uniqueWords[Math.floor(Math.random() * uniqueWords.length)];
    }

    story.push(word);
    recentWords.push(word);
    recentWords = recentWords.slice(-4);

    yield word;
  }
}

function needMore() {
  return innerHeight + (document.body.scrollTop || document.documentElement.scrollTop) + 300 > document.body.getBoundingClientRect().height;
}

function init() {
  if (window.a) {
    window.onscroll = attemptGetGen;
    window.onresize = attemptGetGen;

    attemptGetGen();
  } else {
    requestAnimationFrame(init);
  }
}

let logicScript = document.createElement('script');
logicScript.src = './test.js';
logicScript.setAttribute('async', 'async');
document.head.appendChild(logicScript);

init();
