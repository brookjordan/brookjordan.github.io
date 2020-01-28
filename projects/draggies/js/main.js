function buildDraggy({
  images: imageDir = "i",
  prefix: imagePrefix = "Head",
  suffix: imageSuffix = "",
  start: imageStart = 1,
  end: imageEnd = 297,
  pad: imagePad = 3,
  speed: speed = 0.02,
  width: width = 100,
  height: height = 100,
}) {
  const moveElt = createMoveEltFunc();
  const images = Array.from(
    { length: imageEnd - imageStart },
    (_, i) => `${imagePrefix + pad(imageEnd - i, imagePad, "0") + imageSuffix}.png`
  );
  const elts = images.map(imageName => {
    const elt = document.createElement("div");
    moveElt(elt, 0, 0);
    elt.style.backgroundImage = `url(${imageDir}/${imageName})`;
    return {
      elt,
      x: 0,
      y: 0,
    };
  });
  const styleElt = document.createElement('style');

  let XX = 0;
  let YY = 0;
  let position = 1;

  function followMouse() {
    let prevX;
    let prevY;

    [...elts].forEach(elt => {
      if (typeof prevX === "undefined") {
        xx = XX;
        yy = YY;
      } else {
        xx = prevX;
        yy = prevY;
      }

      elt.x = (elt.x * speed + xx) / (1 + speed);
      elt.y = (elt.y * speed + yy) / (1 + speed);

      moveElt(elt.elt, elt.x, elt.y);

      prevX = elt.x;
      prevY = elt.y;
    });

    requestAnimationFrame(followMouse);
  }

  function createMoveEltFunc() {
    if (transform2D) {
      return ({ style }, x, y) => {
        style[transform2D] = `translate(${x}px,${y}px)`;
      };
    } else {
      return ({ style }, x, y) => {
        style.left = `${x}px`;
        style.top = `${y}px`;
      };
    }
  }

  function setMouse(pointerEvent) {
    if (event.touches) {
      pointerEvent = event.touches[event.touches.length - 1];
    }
    let { pageX, pageY } = pointerEvent;
    XX = pageX - width / 2;
    YY = pageY - height / 2;
  }

  function allowDrag() {
    window.addEventListener("mouseleave", stopDrag, false);
    window.addEventListener("mouseup", stopDrag, false);
    window.addEventListener("touchend", stopDrag, false);

    window.removeEventListener("mousedown", allowDrag, false);
    window.removeEventListener("touchstart", allowDrag, false);

    window.addEventListener("mousemove", setMouse, false);
    window.addEventListener("touchmove", setMouse, false);
  }

  function stopDrag() {
    window.removeEventListener("mouseleave", stopDrag, false);
    window.removeEventListener("mouseup", stopDrag, false);
    window.removeEventListener("touchend", stopDrag, false);

    window.removeEventListener("mousemove", setMouse, false);
    window.removeEventListener("touchmove", setMouse, false);

    window.addEventListener("mousedown", allowDrag, false);
    window.addEventListener("touchstart", allowDrag, false);
  }

  function flipDraggy() {
    if (position === 1) {
      rebuildFeetup();
    } else {
      rebuildHeadup();
    }
  }

  function rebuildHeadup() {
    elts.forEach((_elt, i) => {
      switchSoon(i, i);
    });
    position = 1;
  }

  function rebuildFeetup() {
    elts.forEach((_elt, i, elts) => {
      switchSoon(i, elts.length - i - 1);
    });
    position = 0;
  }

  function switchSoon(i, j) {
    setTimeout(() => {
      document.body.appendChild(elts[i].elt);
    }, 18 * j);
  }

  styleElt.innerHTML = `
    div {
      width: ${width}px;
      height: ${height}px;
    }
  `;
  document.body.appendChild(styleElt);

  document.body.appendChild(elts.reduce((spritesFragment, elt) => {
    spritesFragment.append(elt.elt);
    return spritesFragment;
  }, document.createDocumentFragment()));

  window.addEventListener("mousedown", allowDrag, false);
  window.addEventListener("mousedown", setMouse, false);
  window.addEventListener("touchstart", allowDrag, false);
  window.addEventListener("touchstart", setMouse, false);
  window.addEventListener("dblclick", flipDraggy, false);

  requestAnimationFrame(followMouse);
}
