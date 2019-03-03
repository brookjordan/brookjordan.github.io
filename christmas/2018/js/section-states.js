const parallaxElementSelector = '.pp:not(.pp--0)';
const options = {
  root: null,
  rootMargin: '0px',
  threshold: 0,
}
const onReadyActions = [];
let sectionStatesInitialised = false;
let observationsRanCount = 0;

const sections = window.sections = Array.from(document.querySelectorAll('.section > div'))
  .map(element => {
    let data = {
      element,
      active: false,
      parallaxElements: Array.from(element.querySelectorAll(parallaxElementSelector)),
    };
    element.classList.add('hidden');
    data.observer = new IntersectionObserver(buildSectionTest(data), options);
    data.observer.observe(element);

    return data;
  });

export default sections;
export function onready(func) {
  if (sectionStatesInitialised) {
    func();
  } else {
    onReadyActions.push(func);
  }
};

function buildSectionTest(section) {
  return ([{ isIntersecting }], _observer) => {
    section.active = isIntersecting;
    requestAnimationFrame(function() {
      if (isIntersecting) {
        section.element.classList.remove('hidden');
      } else {
        section.element.classList.add('hidden');
      }
    });
    if (!sectionStatesInitialised) {
      tryRunningOnReadyFunctions();
    }
  }
}

function tryRunningOnReadyFunctions() {
  observationsRanCount += 1;
  if (observationsRanCount >= sections.length) {
    sectionStatesInitialised = true;
    onReadyActions.forEach(func => func());
    onReadyActions.length = 0;
  }
}
