const ALL_HELPERS = {
  pageX,
  pageY,
};

export default ALL_HELPERS;

export function pageX(e) {
  return e.touches
    ? e.touches[0].clientX
    : e.pageX;
}

export function pageY(e) {
  return e.touches
    ? e.touches[0].clientY
    : e.pageY;
}
