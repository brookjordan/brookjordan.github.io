const ALL_HELPERS = {
  passNoEvent,
  callWithParams,
  preventDefaultThen,
};

export default ALL_HELPERS;

export function preventDefaultThen(func, params = []) {
  return event => {
    event.preventDefault();
    func(...params);
  };
}

export function passNoEvent(func) {
  return () => {
    func();
  };
}

export function callWithParams(func, params = []) {
  return () => {
    func(...params);
  };
}
