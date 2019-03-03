import PointerBreadcrumb from './pointer-breadcrumb.js';


const pointerBreadcrumbs = [];
const TOUCH_EVENTS = [
  'touchstart',
  'touchend',
  'touchmove',
];
let maxBreadcrumbCount = 100;

const PointerTrace = {
  get breadcrumbs() {
    return pointerBreadcrumbs.slice(0);
  },
};


export default PointerTrace;


window.addEventListener('mouseenter', traceMouse);
window.addEventListener('mousedown', traceMouse);
window.addEventListener('mousemove', traceMouse);
window.addEventListener('mouseup', traceMouse);
window.addEventListener('mouseleave', traceMouse);
window.addEventListener('touchstart', traceMouse);
window.addEventListener('touchmove', traceMouse);
window.addEventListener('touchend', traceMouse);
window.addEventListener('touchcancel', traceMouse);


function traceMouse(event,
                    {
                      preventDefault  = false,
                      preventMouseSim = true
                    } = {}) {
  if (preventDefault || preventMouseSim && TOUCH_EVENTS.includes(event.type)) {
    event.preventDefault();
  }

  pointerBreadcrumbs.push(new PointerBreadcrumb(event));
  if (pointerBreadcrumbs.length > maxBreadcrumbCount) {
    pointerBreadcrumbs.splice(0, pointerBreadcrumbs.length - maxBreadcrumbCount);
  }
};
