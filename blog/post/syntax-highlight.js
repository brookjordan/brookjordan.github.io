export default function tryToHighlight() {
  if (Rainbow) {
    Rainbow.color();
  } else {
    requestAnimationFrame(tryToHighlight);
  }
}
