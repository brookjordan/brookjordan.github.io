export const pressedKeys = {};

const downEvents = {};
const upEvents = {};

window.addEventListener('keydown', handleKeyDown);

window.addEventListener('keyup', handleKeyUp);

export function fireKeyUp(key) {
  handleKeyUp({
    key,
  });
}

export function fireKeyDown(key) {
  handleKeyDown({
    key,
  });
}

export function addDown(on, callback) {
  downEvents[on] || (downEvents[on] = []);
  downEvents[on].push(callback);
}

export function addUp(on, callback) {
  upEvents[on] || (upEvents[on] = []);
  upEvents[on].push(callback);
}

function handleKeyUp(e) {
  if (upEvents[e.key] && upEvents[e.key].length) {
    e.preventDefault && e.preventDefault();
    upEvents[e.key].forEach(callback => callback());
  }
  delete pressedKeys[e.key];
}

function handleKeyDown(e) {
  if (!pressedKeys[e.key] && downEvents[e.key] && downEvents[e.key].length) {
    e.preventDefault && e.preventDefault();
    downEvents[e.key].forEach(callback => callback());
  }
  pressedKeys[e.key] = {};
}
