import sectionStates, { onready } from '../js/section-states.js';

export default function() {
  onready(() => {
    setParallaxState();
  });
  window.addEventListener('scroll', setParallaxState, {
    passive: true,
  });
  window.addEventListener('resize', setParallaxState, {
    passive: true,
  });
}

function setParallaxState(_event) {
  const innerHeight    = window.iosInnerHeight();
  const sectionSize    = document.querySelector('.section:nth-child(2) > div').clientHeight;
  const travelDistance = sectionSize + innerHeight;

  sectionStates
    .filter(({ active }) => active)
    .forEach(({
      element: section,
      parallaxElements,
    }) => {
      let { top } = section.getBoundingClientRect();
      parallaxElements.forEach(elt => {
        parrelElt(elt, top, sectionSize, innerHeight);
      });
      requestAnimationFrame(() => {
        section.style.setProperty('--distance-travelled', (innerHeight - top) / (sectionSize + innerHeight));
      });
    });
}

function parrelElt(elt, top, sectionSize, innerHeight) {
  let { height } = elt.getBoundingClientRect();
  let raceLength = sectionSize - height;
  let sectionAt;

  if (raceLength <= 0) {
    let travelDistance = sectionSize + innerHeight;
    sectionAt = (innerHeight - top) / travelDistance;
  } else {
    sectionAt = (-top / (sectionSize - innerHeight));
  }
  let pos = raceLength * sectionAt;
  requestAnimationFrame(() => {
    elt.style.transform = `translateY(${pos}px)`;
  });
}
