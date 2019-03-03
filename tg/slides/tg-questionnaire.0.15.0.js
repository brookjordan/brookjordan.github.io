'use strict';

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

function runTGQuestionnaire(questions) {
  var _ref = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
      _ref$initialQuestion = _ref.initialQuestion,
      initialQuestion = _ref$initialQuestion === undefined ? 0 : _ref$initialQuestion,
      _ref$failureQuestion = _ref.failureQuestion,
      failureQuestion = _ref$failureQuestion === undefined ? 0 : _ref$failureQuestion,
      _ref$winCount = _ref.winCount,
      winCount = _ref$winCount === undefined ? 10 : _ref$winCount,
      _ref$maxNoCount = _ref.maxNoCount,
      maxNoCount = _ref$maxNoCount === undefined ? Infinity : _ref$maxNoCount,
      _ref$baseClass = _ref.baseClass,
      baseClass = _ref$baseClass === undefined ? 'tg-questions' : _ref$baseClass,
      _ref$rootEltSelector = _ref.rootEltSelector,
      rootEltSelector = _ref$rootEltSelector === undefined ? '.tg-questions' : _ref$rootEltSelector;

  failureQuestions = failureQuestions.map(function (questionID) {
    return questions[questionID];
  });

  var rootElt = document.querySelector(rootEltSelector);
  var meters = rootElt.querySelectorAll(childSelector('meter'));
  var container = rootElt.querySelector(childSelector('slides'));
  var slide1 = rootElt.querySelector(childSelector('slide--1'));
  var slide2 = rootElt.querySelector(childSelector('slide--2'));
  var restart = rootElt.querySelector(childSelector('restart'));

  var noQuestionClass = childClassName('slide--no-answers');
  var noCTAClass = childClassName('slide--no-cta');

  var initialSlide = slide1;

  var yesAnswers = Array.from(rootElt.querySelectorAll(childSelector('button--yes')));
  var noAnswers = Array.from(rootElt.querySelectorAll(childSelector('button--no')));
  var allAnswers = [].concat(_toConsumableArray(yesAnswers), _toConsumableArray(noAnswers));

  var startColor = [66, 155, 206];
  var endColor = [112, 207, 50];

  var answers = [];
  var rounds = [answers];
  var events = {
    finish: [],
    restart: [],
    fail: []
  };

  var noAnswerCount = 0;
  var yesAnswerCount = 0;
  var activeQuestion = questions[initialQuestion];
  var activeSlide = void 0;

  addMeterSegments();
  toggleActive();
  setText();
  setActions();

  function addMeterSegments() {
    var currentColor = void 0;
    var newSegment = void 0;

    Array.from(meters).forEach(function (meterElt) {
      for (var i = 1; i <= winCount; i += 1) {
        currentColor = mixColors(winCount, winCount - i);
        newSegment = document.createElement('div');
        newSegment.className = childClassName('meter-segment');
        newSegment.style.backgroundColor = 'rgb(' + currentColor[0] + ',' + currentColor[1] + ',' + currentColor[2] + ')';
        meterElt.appendChild(newSegment);
      }
    });
  }

  function mixColors(count, point) {
    count = count - 1;
    return [Math.round((startColor[0] * (count - point) + endColor[0] * point) / count - 1), Math.round((startColor[1] * (count - point) + endColor[1] * point) / count - 1), Math.round((startColor[2] * (count - point) + endColor[2] * point) / count - 1)];
  }

  function toggleActive() {
    if (activeSlide) {
      setLeaving(activeSlide);
    }

    if (activeSlide === slide1) {
      activeSlide = slide2;
    } else {
      activeSlide = slide1;
    }

    setActive(activeSlide);

    if (activeQuestion.yes || activeQuestion.no) {
      activeSlide.classList.remove(noQuestionClass);
    } else {
      activeSlide.classList.add(noQuestionClass);

      if (failureQuestions.includes(activeQuestion)) {
        events.fail.forEach(function (func) {
          func(answers, rounds);
        });
      } else {
        events.finish.forEach(function (func) {
          func(answers, rounds);
        });
      }
    }

    if (activeQuestion.ctaURL) {
      activeSlide.classList.remove(noCTAClass);
      activeSlide.querySelector(childSelector('cta-link')).href = activeQuestion.ctaURL;
      activeSlide.querySelector(childSelector('cta-link')).innerText = activeQuestion.ctaText || 'Click here';
      activeSlide.querySelector(childSelector('cta-text')).innerText = activeQuestion.ctaSubtext || '';
    } else {
      activeSlide.classList.add(noCTAClass);
    }
  }

  function setText() {
    activeSlide.querySelector(childSelector('text')).innerHTML = activeQuestion.text;
    activeSlide.querySelector(childSelector('did-you-know')).innerHTML = activeQuestion.subtext || '';
  };

  function setActions() {
    yesAnswers.forEach(function (button) {
      button.addEventListener('click', function (e) {
        updateQuestion('yes');
        toggleActive();
        setText();
      });
    });

    noAnswers.forEach(function (button) {
      button.addEventListener('click', function (e) {
        updateQuestion('no');
        toggleActive();
        setText();
      });
    });

    restart.addEventListener('click', function (e) {
      restartQuestions();
      toggleActive();
      setText();
    });
  }

  function updateQuestion(answer) {
    answers.push({
      answer: answer,
      question: activeQuestion.text
    });

    if (answer === 'no') {
      noAnswerCount += 1;
    } else {
      yesAnswerCount += 1;
    }

    if (noAnswerCount >= maxNoCount && yesAnswerCount < winCount) {
      console.log(yesAnswerCount);
      console.log(winCount);
      activeQuestion = questions[failureQuestion];
    } else {
      activeQuestion = questions[activeQuestion[answer]];
    }
  }

  function restartQuestions() {
    events.restart.forEach(function (func) {
      func(answers, rounds);
    });

    answers = [];
    rounds.push(answers);
    noAnswerCount = 0;
    yesAnswerCount = 0;

    activeQuestion = questions[initialQuestion];
  }

  function setActive(toBeActive) {
    if (!toBeActive) {
      return;
    }

    var meterArrow = toBeActive.querySelector(childSelector('meter-arrow'));
    var newColor = mixColors(winCount + 1, yesAnswerCount);
    slide2.classList.remove(childClassName('slide--active'));
    slide1.classList.remove(childClassName('slide--active'));
    meterArrow.style.borderRightColor = 'rgb(' + newColor[0] + ',' + newColor[1] + ',' + newColor[2] + ')';
    meterArrow.style.bottom = Math.min(100, 100 / winCount * yesAnswerCount) + '%';

    setTimeout(function () {
      if (toBeActive === slide1) {
        slide1.classList.add(childClassName('slide--active'));
      } else {
        slide2.classList.add(childClassName('slide--active'));
      }
    }, 200);
  }

  function setLeaving(toBeLeaving) {
    if (!toBeLeaving) {
      return;
    }

    if (toBeLeaving === slide1) {
      slide1.classList.add(childClassName('slide--leaving'));
      slide2.classList.remove(childClassName('slide--leaving'));
    } else {
      slide2.classList.add(childClassName('slide--leaving'));
      slide1.classList.remove(childClassName('slide--leaving'));
    }
  }

  function childClassName(childID) {
    return baseClass + '__' + childID;
  }

  function childSelector(childID) {
    return '.' + baseClass + '__' + childID;
  }

  return {
    restart: restartQuestions,
    getAnswers: function getAnswers() {
      return {
        answers: answers,
        rounds: rounds
      };
    },
    on: function on(eventName, func) {
      events[eventName] && events[eventName].push(func);
      return this;
    }
  };
}