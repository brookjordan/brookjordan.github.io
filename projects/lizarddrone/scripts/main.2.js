function buildStageModifier(e) {
  function t(e, t) {
    return p = e, m = e / u, v = m / a, m > window.innerHeight && (p = t * u, m = t, v = p / s), g = (e - p) / 2 * h, f = (t - m) / 2 * h, p *= h, m *= h, x = e / v, b = t / v, S = g / v, T = f / v, {
      stageScale: v,
      stageWidth: p,
      stageHeight: m,
      offsetX: g,
      offsetY: f
    }
  }

  function n() {
    w = window.innerWidth, k = window.innerHeight, t(w, k), e.width = w * h, e.height = k * h
  }

  function o(e) {
    return e * v * h + g
  }

  function i(e) {
    return e * v * h + f
  }

  function r(e) {
    return e * v * h
  }
  var s = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : 1,
    a = arguments.length > 2 && void 0 !== arguments[2] ? arguments[2] : 1,
    c = arguments.length > 3 && void 0 !== arguments[3] && arguments[3],
    d = e.getContext("2d"),
    u = s / a,
    h = "boolean" == typeof c ? c ? 2 : 1 : c,
    l = {
      ctx: d,
      canvas: e,
      resizeCanvas: n,
      offsetToStageX: o,
      offsetToStageY: i,
      scaleToStage: r,
      get stageWidth() {
        return x
      },
      get stageHeight() {
        return b
      },
      get worldOffsetX() {
        return S
      },
      get worldOffsetY() {
        return T
      }
    },
    g = void 0,
    f = void 0,
    p = void 0,
    m = void 0,
    v = void 0,
    w = void 0,
    k = void 0,
    x = void 0,
    b = void 0,
    S = void 0,
    T = void 0;
  return l
}

function buildStageCtx() {
  function e(e, t, n, o) {
    var i = !(arguments.length > 4 && void 0 !== arguments[4]) || arguments[4];
    return i ? h.fillRect(l(e), g(t), f(n), f(o)) : h.fillRect(f(e), f(t), f(n), f(o))
  }

  function t(e, t, n, o, i) {
    var r = !(arguments.length > 5 && void 0 !== arguments[5]) || arguments[5];
    return r ? h.drawImage(e, l(t), g(n), f(o), f(i)) : h.drawImage(e, f(t), f(n), f(o), f(i))
  }

  function n(e, t, n, o, i, r, s, a, c) {
    var d = !(arguments.length > 9 && void 0 !== arguments[9]) || arguments[9];
    return d ? h.drawImage(e, t, n, o, i, l(r), g(s), f(a), f(c)) : h.drawImage(e, t, n, o, i, f(r), f(s), f(a), f(c))
  }

  function o(e) {
    return h.rotate(e)
  }

  function i(e, t) {
    return h.translate(l(e), g(t))
  }

  function r(e, t, n, o) {
    return h.createLinearGradient(f(e), f(t), f(n), f(o))
  }

  function s() {
    return h.save()
  }

  function a() {
    return h.restore()
  }

  function c(e, t, n) {
    var o = !(arguments.length > 3 && void 0 !== arguments[3]) || arguments[3];
    return o ? h.fillText(e, l(t), g(n)) : h.fillText(e, f(t), f(n))
  }

  function d(e, t) {
    return h.font = f(e) + "px " + t
  }
  var u = arguments.length > 0 && void 0 !== arguments[0] ? arguments[0] : {},
    h = (u.resize, u.canvas, u.ctx),
    l = u.offsetToStageX,
    g = u.offsetToStageY,
    f = u.scaleToStage,
    p = {
      fillRect: e,
      drawImage: t,
      drawImagePart: n,
      rotate: o,
      translate: i,
      save: s,
      restore: a,
      createLinearGradient: r,
      fillText: c,
      font: d,
      _: h,
      set fillStyle(e) {
        h.fillStyle = e
      },
      get fillStyle() {
        return h.fillStyle
      }
    };
  return p
}

function sim(e) {
  firstRun ? (init$1(e), firstRun = false) : simUnit(e)
}

function init$1(e) {
  pos.x = 1.5 * squareWidth, pos.y = e.height / 2
}

function keyUp(e) {
  controls[e].up && controls[e].up()
}

function keyDown(e) {
  controls[e].down && controls[e].down()
}

function jump(e) {
  e && e.preventDefault(), speed.y = -jumpPower
}

function simUnit(e) {
  speed.x && (pos.x += speed.x, pos.x < squareWidth / 2 ? pos.x = squareWidth / 2 : pos.x > e.width - squareWidth / 2 && (pos.x = e.width - squareWidth / 2)), pos.y += speed.y, speed.y = (speed.y + gravity) * airResistance, pos.y < squareHeight / 2 ? (speed.y *= -bounceFriction, pos.y = squareHeight / 2) : pos.y >= e.height - squareHeight / 2 && (speed.y = Math.abs(speed.y) > settleSpeed ? speed.y * -bounceFriction : 0, pos.y = e.height - squareHeight / 2), pos.rot = rotationFunction(speed.y)
}

function controlBlocks(e, t) {
  if (simRunning) {
    for (; !blocks.length || blocks[blocks.length - 1].x < e.tools.stageWidth - blockSpacing;) newBlock(e);
    for (var n = 0, o = blocks.length; n < o && blocks[n].x < -e.tools.worldOffsetX - blockWidth; o += 1) blocks.shift();
    insideGapPreviously = insideGap, insideGap = false, blocks.forEach(function (e) {
      return collideBlock(e, t)
    }), insideGapPreviously && !insideGap && (score.current += 1)
  } else blocks.length ? (insideGapPreviously = false, insideGap = false, score.current > score.high && (score.high = score.current, sendScore(score.high)), score.current = 0, blocks.forEach(function (e) {
    return e.opening = e.opening || .5 * Math.random() + .3
  })) : restartSim();
  blocks.forEach(function (t) {
    return controlBlock(t, e)
  })
}

function controlBlock(e, t) {
  e.x -= .1, e.opening && (e.gap += e.opening, e.opening *= 1.5, e.gap > 2 * t.height && blocks.splice(blocks.indexOf(e), 1))
}

function collideBlock(e, t) {
  if (e.x < t.pos.x + .5 && e.x > t.pos.x - t.size.width / 4 - .5) {
    if (insideGap = true, t.pos.y - t.size.height / 4 < e.height - e.gap / 2) return pauseSim(), true;
    if (t.pos.y + t.size.height / 4 > e.height + e.gap / 2) return pauseSim(), true
  }
  return false
}

function newBlock(e) {
  var t = blocks[blocks.length - 1];
  blocks.push({
    x: t ? t.x + blockSpacing : e.tools.stageWidth,
    width: blockWidth,
    height: Math.random() * (gapHeightMax - gapHeightMin) + gapHeightMin,
    gap: gapsize,
    opening: false
  })
}

function pauseSim() {
  simRunning = false
}

function restartSim() {
  simRunning = true
}

function renderSquare(e, t, n, o, i, r) {
  var s = arguments.length > 6 && void 0 !== arguments[6] ? arguments[6] : 0;
  e.ctx.save(), e.ctx.translate(i, r), e.ctx.rotate(s), e.ctx.drawImage(t, -n / 2, -o / 2, n, o, false), e.ctx.restore()
}

function renderBounds(e) {
  e.ctx.fillStyle = "#4b4547", e.ctx._.fillRect(0, 0, e.canvas.width, e.canvas.height, false)
}

function renderBlocks(e, t, n, o) {
  t.blocks.forEach(function (i) {
    return renderBlock(i, e, n, o, t.score)
  })
}

function renderBlock(e, t, n, o, i) {
  var r = e.height - e.gap / 2,
    s = 8 * e.width;
  t.ctx.drawImage(n, e.x, r - s, e.width, s), t.ctx.drawImage(o, e.x, e.height + e.gap / 2, e.width, s), t.ctx.fillStyle = "#3a302c", t.ctx.font(1, "'Open Sans', sans-serif"), t.ctx.fillText("" + i.current, .4, 1.2, false), t.ctx.font(.5, "'Open Sans', sans-serif"), t.ctx.fillText("Hi-Score: " + i.high, .4, 2.2, false)
}

function tick() {
  for (var e in activeThreads) activeThreads[e].run();
  requestAnimationFrame(tick)
}

function addThread() {
  var e = arguments.length > 0 && void 0 !== arguments[0] ? arguments[0] : ++uuid,
    t = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : {};
  if (activeThreads[e] || idleThreads[e]) throw new Error("Thread with ID " + e + " already exists.");
  var n = new Thread(e, t);
  return activeThreads[e] = n, n
}

function Thread(e) {
  var t = this,
    n = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : {},
    o = n.fps,
    i = void 0 === o ? 60 : o,
    r = (n.active, n.tasks),
    s = void 0 === r ? [] : r,
    a = n.frame,
    c = void 0 === a ? 0 : a,
    d = n.simulate,
    u = void 0 === d || d,
    h = +new Date;
  this.id = e, this.resetFrame = function () {
    c = 0
  }, this.destroy = function () {
    delete activeThreads[e]
  }, this.play = function () {
    h = +new Date, activeThreads[e] = t, delete idleThreads[e]
  }, this.pause = function () {
    idleThreads[e] = t, delete activeThreads[e]
  }, this.addTask = function (e) {
    s.indexOf(e) === -1 && s.push(e.bind(t))
  }, this.removeTask = function (e) {
    var t = s.indexOf(e);
    t > -1 && s.splice(t, 1)
  }, this.run = function () {
    var e = +new Date;
    (!u || h < e) && (s.forEach(function (e) {
      e()
    }), h += 1e3 / i, c += 1, u && t.run())
  }, Object.defineProperty(this, "frame", {
    get: function () {
      return c
    },
    set: function (e) {
      return c
    }
  })
}

function init() {
  renderThread.addTask(render), renderQueue.push(function () {
    return renderSquare(stage, images.mokoCopter, control.size.width, control.size.height, control.pos.x, control.pos.y, control.pos.rot)
  }), stage.tools.resizeCanvas(), control.init(stage), window.addEventListener("resize", stage.tools.resizeCanvas), window.addEventListener("touchstart", addSim), window.addEventListener("mousedown", addSim), window.addEventListener("keydown", addSim)
}

function loadImages() {
  var e = 0;
  return new Promise(function (t, n) {
    imageURLs.forEach(function (n) {
      var o = new Image;
      o.onload = function () {
        e += 1, e === imageURLs.length && t()
      }, o.src = n[1], images[n[0]] = o
    })
  })
}

function render() {
  renderQueue.forEach(function (e) {
    e()
  })
}

function addSim() {
  window.removeEventListener("touchstart", addSim), window.removeEventListener("mousedown", addSim), window.removeEventListener("keydown", addSim), simThread.addTask(controlSim), setTimeout(function () {
    return simThread.addTask(function () {
      return blocks$1.sim(stage, control)
    })
  }, 0)
}

function controlSim() {
  control.sim(stage)
}
function rotationFunction (e) {
  return Math.max(-.1, Math.min(.3, .8 * e))
}
let canvasElement = document.getElementById("spryt-stage");
let stageWidth = 9;
let stageHeight = 15;
let retinaScale = window.devicePixelRatio;
let stageTools = buildStageModifier(canvasElement, stageWidth, stageHeight, retinaScale);
let stageCtx = buildStageCtx(stageTools);
let stage = {
  tools: stageTools,
  ctx: stageCtx,
  canvas: canvasElement,
  width: stageWidth,
  height: stageHeight
};
let squareWidth = 1.5;
let squareHeight = 1 * squareWidth;
let jumpPower = .4;
let sideSpeed = .1;
let gravity = .02;
let bounceFriction = .5;
let airResistance = .99;
let settleSpeed = .1;
let pos = {};
let speed = {
  x: 0,
  y: 0
};
let size = {
  width: squareWidth,
  height: squareHeight
};
let controls = {
  ArrowUp: {
    down: jump,
    up() {}
  },
  Space: {
    down: jump,
    up() {}
  },
  Enter: {
    down: jump,
    up() {}
  },
  ArrowRight: {
    down() {
      speed.x = sideSpeed
    },
    up() {
      speed.x = 0
    }
  },
  ArrowLeft: {
    down() {
      speed.x = -sideSpeed
    },
    up() {
      speed.x = 0
    }
  }
};
let firstRun = true;
let control = {
  sim: sim,
  init: init$1,
  pos: pos,
  size: size
};
window.addEventListener("keydown", (e) => {
  controls[e.code] && (e.preventDefault(), keyDown(e.code))
});
window.addEventListener("keyup", (e) => {
  controls[e.code] && (e.preventDefault(), keyUp(e.code))
});
window.addEventListener("mousedown", jump);
window.addEventListener("touchstart", jump);
let userName = localStorage.getItem("mokoDroneUsername") || prompt("Enter your username!", "");
let highScore = localStorage.getItem("mokoDroneHiscore") ? +localStorage.getItem("mokoDroneHiscore") : 0;
localStorage.setItem("mokoDroneUsername", userName);
function sendScore (e) {
  if (e > +highScore) {
    localStorage.setItem("mokoDroneHiscore", e);
    var t = {
        text: userName + " just got a new highscore of " + e + "! <http://brook.dev/tg/moko|Try beat them.>"
      },
      n = new XMLHttpRequest;
    n.open("POST", "https://hooks.slack.com/services/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"), n.send(JSON.stringify(t)), highScore = e
  }
}
let blocks = [];
let blockWidth = 1;
let blockSpacing = 6;
let gapsize = 4.5;
let gapHeightMin = 4;
let gapHeightMax = 11;
let score = {
  current: 0,
  high: 0
};
let simRunning = true;
let insideGap = false;
let insideGapPreviously = insideGap;
let blocks$1 = {
  sim: controlBlocks,
  blocks: blocks,
  score: score,
  pause: pauseSim,
  restart: restartSim
};
let activeThreads = {};
let idleThreads = {};
let threadRunner = {
  addThread: addThread,
  __activeThreads: activeThreads,
  __idleThreads: idleThreads
};
let uuid = 0;

tick();

let simThread = threadRunner.addThread("sim-thread", {
  fps: 60
});
let renderThread = threadRunner.addThread("render-thread", {
  fps: 10,
  simulate: false
});
let renderQueue = [
  function () {
    return renderBounds(stage)
  },
  function () {
    return renderBlocks(stage, blocks$1, images.lamp, images.crates)
  }
];
let imageURLs = [
  ["mokoCopter", "http://brook.dev/tg/moko/images/moko-copter.png"],
  ["lamp", "http://brook.dev/tg/moko/images/lamp.png"],
  ["crates", "http://brook.dev/tg/moko/images/crates.png"]
];
let images = {};
loadImages().then(init);
