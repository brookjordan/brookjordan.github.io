(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
'use strict';

var _createRace = require('../method/createRace');

var _createRace2 = _interopRequireDefault(_createRace);

var _runRace = require('../method/runRace');

var _runRace2 = _interopRequireDefault(_runRace);

var _promptNumber = require('../method/promptNumber');

var _promptNumber2 = _interopRequireDefault(_promptNumber);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var track = document.querySelector('.track');
var racerElts = document.querySelectorAll('.racer');
var raceDuration = (0, _promptNumber2.default)() * 1000;
var startTime = undefined;

var racers = (0, _createRace2.default)(racerElts, raceDuration); //make this a race object
(0, _runRace2.default)(racers, raceDuration);

},{"../method/createRace":2,"../method/promptNumber":3,"../method/runRace":4}],2:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = setRacers;
function setRacers(racerElts, raceDuration) {
  var racers = [];

  Array.from(racerElts).forEach(function (racerElt) {
    var racerName = racerElt.getAttribute('data-name');
    var racerDuration = raceDuration;
    var stages = [0, racerDuration / 2, racerDuration];
    var stageCount = Math.floor(Math.random() * 200) + 100;
    while (--stageCount) {
      if (Math.random() > 0.55) {
        splitLargestStep(stages);
      } else {
        splitRandomStep(stages);
      }
    }

    var banner = document.createElement('div');
    var figure = document.createElement('div');
    var counter = document.createElement('div');

    banner.className = 'banner';
    figure.className = 'figure';
    counter.className = 'counter';

    racerElt.appendChild(banner);
    racerElt.appendChild(figure);
    racerElt.appendChild(counter);

    racerElt.classList.add(racerName);

    racers.push({
      elt: racerElt,
      counterElt: counter,
      name: racerName,
      time: racerDuration,
      stages: stages
    });
  });

  return racers;
}

function splitRandomStep(array) {
  addStep(array, Math.floor(Math.random() * (array.length - 1)));
}

function addStep(array, i) {
  array.splice(i + 1, 0, array[i] + Math.random() * 0.7 * (array[i + 1] - array[i]));
}

function splitLargestStep(array) {
  var largest = 0;
  var largestIndex = 0;

  array.forEach(function (item, index) {
    if (index !== 0) {
      var diff = item - array[index - 1];

      if (diff > largest) {
        largest = Math.max(largest, item - array[index - 1]);
        largestIndex = index - 1;
      }
    }
  });

  addStep(array, largestIndex);
}

},{}],3:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = promptForNumber;
function promptForNumber(_message) {
  var message = _message ? message : 'How many seconds should the race be?';
  var dur = parseInt(prompt(message, 60));

  if (isNaN(dur)) {
    return getDuration('That\s not a number.\nHow may seconds should the race be?');
  }

  return dur;
}

},{}],4:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = raceRacers;
function raceRacers(racers) {
  var nextFrame = undefined;
  var startTime = +new Date();

  runNextFrame();

  function runNextFrame() {
    var time = +new Date() - startTime;
    var raceWasWon = false;

    racers.forEach(function (racer) {
      if (raceWasWon) return false;

      var stageLength = 100 / racer.stages.length;
      var raceFinished = false;
      var i = undefined;
      for (i = 0; i < racer.stages.length; ++i) {
        if (time < racer.stages[i]) {
          if (i === racer.stages.length - 1) {
            raceFinished = true;
          }
          break;
        }
      }
      var timeToEndOfStage = racer.stages[i];
      var timeToEndOfPrevStage = i ? racer.stages[i - 1] : 0;
      var timeToBeOnStage = timeToEndOfStage - timeToEndOfPrevStage;
      var timeOnStage = time - timeToEndOfPrevStage;
      var racerPosition = raceFinished ? 100 : i * stageLength + timeOnStage / timeToBeOnStage * stageLength;

      racer.elt.style.WebkitTransform = 'translateY(-100%) rotate(10deg)\n                                         translateX(' + (racerPosition * 45 - 50) + '%)';

      racer.counterElt.innerHTML = Math.floor(racerPosition * 10000) / 100 + 'km';

      if (racerPosition >= 100) {
        raceWasWon = true;
        cancelAnimationFrame(nextFrame);

        setTimeout(function () {
          alert(racer.name + ' wins!');
        }, 4);
      }
    });

    nextFrame = requestAnimationFrame(runNextFrame);
  }
}

},{}]},{},[1]);
