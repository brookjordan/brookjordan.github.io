var audio = document.querySelector('audio');
var boomerContainer = document.querySelector('.boomers');
var startButton = document.querySelector('#start-button');

audio.addEventListener('canplay', showStartButton);
audio.addEventListener('canplaythrough', showStartButton);
startButton.onclick = function() {
  audio.play();
  startButton.className = 'started';
}
audio.addEventListener('timeupdate', function() {
  if (audio.currentTime > 64) {
    boomerContainer.className = 'boomers';
  }
});
audio.src = "./sound/six-white-boomers.mp3";

function showStartButton() {
  if (!startButton.className) {
    startButton.className = 'can-start';
  }
}



window.onmousemove = window.ontouchmove = window.ontouchstart = function(event) {
  var touch = event.touches ? event.touches[0] : event;
  var largestDimension = Math.max(window.innerWidth, window.innerHeight);
  setProps({
    x: (touch.clientX - window.innerWidth / 2) / largestDimension,
    y: (touch.clientY - window.innerHeight / 2) / largestDimension,
  });
}

function setProps(vars) {
  document.documentElement.style.setProperty(
    '--x',
    vars.x,
  );
  document.documentElement.style.setProperty(
    '--y',
    vars.y,
  );
}


var radios = document.querySelectorAll('.boomer-bob > [type="radio"]');

for (var i = 0; i < radios.length; i += 1) {
  radios[i].onchange = radios[i].onclick = function() {
    setSearchParams();
  }
}

function setSearchParams() {
  if (!history) { return; }
  var checkedRadios = document.querySelectorAll('.boomer-bob > [type="radio"]:checked');
  var checkedString = '';
  for (var i = 0; i < checkedRadios.length; i += 1) {
    if (checkedString) {
      checkedString += ',';
    }
    checkedString += checkedRadios[i].getAttribute('id').split('-')[0];
  }
  history.replaceState(null, '', location.href.split('?')[0] + '?boomers=' + checkedString);
}



var pickSets = {
  default: 'terry,chris,page,leon,brett,chantal'.split(','),
  dad: 'gareth,chris,clive,emma,brett,chantal'.split(','),
  nana: 'gareth,chris,clive,page,brett,chantal'.split(','),
  siblings: 'gareth,june,terry,page,brett,leon'.split(','),
  mcardle: 'chris,terry,page,cliff,june,leon'.split(','),
  jordan: 'brett,chris,page,gareth,clive,chantal'.split(','),
  billingtons: 'brett,page,antony,chris,gareth,emma'.split(','),
};

var boomers = document.querySelectorAll('.boomer');
setInitalPicks();

function setInitalPicks() {
  var searchParams = location.href.split('?')[1];
  var initialPicks;

  if (!searchParams) { return; }

  searchParams = searchParams.split('#')[0];
  searchParams = searchParams.split('&');

  for (var i = 0; i < searchParams.length; i += 1) {
    if (searchParams[i].indexOf('boomers=') === 0) {
      initialPicks = searchParams[i].slice(8).split(',');
    } else if (
      searchParams[i].indexOf('set=') === 0
      && pickSets[searchParams[i].slice(4)]
    ) {
      initialPicks = pickSets[searchParams[i].slice(4)];
    } else {
      continue;
    }

    for (var j = 0; j < initialPicks.length; j += 1) {
      var pick = initialPicks[j];
      boomers[j].querySelector('[for^="' + pick + '--').click();
    }

    break;
  }
}
