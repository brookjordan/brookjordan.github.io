let activeThreads = {};
let idleThreads = {};
let uuid = 0;

export const threadRunner = {
  addThread,
  __activeThreads: activeThreads,
  __idleThreads: idleThreads,
};

function tick() {
  for (const e in activeThreads) activeThreads[e].run();
  requestAnimationFrame(tick);
}

function addThread(...args) {
  const e = args.length <= 0 || void 0 === args[0] ? ++uuid : args[0];

  const t = args.length <= 1 || void 0 === args[1] ? {} : args[1];
  if (activeThreads[e] || idleThreads[e])
    throw new Error(`Thread with ID ${e} already exists.`);
  const i = new Thread(e, t);
  return (activeThreads[e] = i), i;
}

function Thread(e) {
  const t = this;
  const i =
    arguments.length <= 1 || void 0 === arguments[1] ? {} : arguments[1];
  const a = i.fps;
  const r = void 0 === a ? 60 : a;
  const d = (i.active, i.tasks);
  const n = void 0 === d ? [] : d;
  const s = i.frame;
  let h = void 0 === s ? 0 : s;
  const u = i.simulate;
  const c = void 0 === u ? !0 : u;
  let o = +new Date();
  (this.id = e),
    (this.resetFrame = () => {
      h = 0;
    }),
    (this.destroy = () => {
      delete activeThreads[e];
    }),
    (this.play = () => {
      (o = +new Date()), (activeThreads[e] = t), delete idleThreads[e];
    }),
    (this.pause = () => {
      (idleThreads[e] = t), delete activeThreads[e];
    }),
    (this.addTask = (e) => {
      !n.includes(e) && n.push(e.bind(t));
    }),
    (this.removeTask = (e) => {
      const t = n.indexOf(e);
      t > -1 && n.splice(t, 1);
    }),
    (this.run = () => {
      const e = +new Date();
      c &&
        e > o &&
        (n.forEach((e) => {
          e();
        }),
        (o += 1e3 / r),
        (h += 1),
        c && t.run()),
        c || t.run();
    }),
    Object.defineProperty(this, "frame", {
      get() {
        return h;
      },
      set(e) {
        return h;
      },
    });
}

tick();
