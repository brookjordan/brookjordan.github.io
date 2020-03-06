//let dpr = globalThis.devicePixelRatio || 1;

const colourStarts = [
  [350, 20],
  [250, -20],
  [50, -10]
];
const COLOURS = colourStarts.map(([deg, offset]) => {
  return {
    bg: `hsl(${deg}, 100%, 93%)`,
    stroke: `hsl(${deg + offset}, 60%, 50%)`,
  };
});

function pos(x, y, accX, accY = accX) {
  return [
    x + Math.random() * accX,
    y + Math.random() * accY,
  ];
}

function rnd(n1, n2) {
  return Math.random() > 0.5 ? n1 : n2;
}

class PostItPainter {
  static get inputProperties() { return ["--only"]; }

  paint(ctx, geometry, properties) {
    const PD = { // postItDefinition
      w: geometry.width,
      h: geometry.height,
      acc: 10,
      strokeWidth: 1 /* * dpr */,
    };
    PD.s2 = PD.strokeWidth / 2;

    ctx.beginPath();
    let firstPoint = pos(
      PD.s2,
      PD.h - PD.s2,
      PD.acc,
      -PD.acc
    );

    ctx.moveTo(...firstPoint);
    ctx.bezierCurveTo(
      rnd(PD.s2, PD.acc),
      rnd(PD.h - PD.s2, PD.h - PD.acc),
      rnd(PD.s2, PD.acc),
      rnd(PD.s2, PD.acc),
      ...pos(
        PD.s2,
        PD.s2,
        PD.acc
      )
    );
    ctx.bezierCurveTo(
      rnd(PD.s2, PD.acc),
      rnd(PD.s2, PD.acc),
      rnd(PD.w - PD.s2, PD.w - PD.acc),
      rnd(PD.s2, PD.acc),
      ...pos(
        PD.w - PD.s2,
        PD.s2,
        -PD.acc,
        PD.acc
      )
    );
    ctx.bezierCurveTo(
      rnd(PD.w - PD.s2, PD.w - PD.acc),
      rnd(PD.s2, PD.acc),
      rnd(PD.w - PD.s2, PD.w - PD.acc),
      rnd(PD.h - PD.s2, PD.h - PD.acc),
      ...pos(
        PD.w - PD.s2,
        PD.h - PD.s2,
        -PD.acc
      )
    );
    let isOnly = properties.get("--only").toString().trim() === "true";
    if (isOnly) {
      ctx.closePath();
    }

    let theme = COLOURS[Math.floor(Math.random() * COLOURS.length)];
    ctx.fillStyle = theme.bg;
    ctx.fill();

    if (!isOnly) {
      ctx.globalCompositeOperation = "destination-out";
      let tH = 75; // transparencyHeight
      let grd = ctx.createLinearGradient(0, PD.h - tH, 0, PD.h);
      grd.addColorStop(0, "transparent");
      grd.addColorStop(1, "black");
      ctx.fillStyle = grd;
      ctx.fillRect(0, PD.h - tH, PD.w, tH);

      ctx.globalCompositeOperation = "source-over";
    }

    ctx.lineWidth = PD.strokeWidth;
    ctx.strokeStyle = theme.stroke;
    ctx.stroke();
  }
}

registerPaint("post-it", PostItPainter);
