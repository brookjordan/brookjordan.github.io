const maxRunCount = 2 ** 10;
let activeThreads = {};
let idleThreads = {};
let uuid = 0;

export const threadRunner = {
  addThread,
  __activeThreads: activeThreads,
  __idleThreads: idleThreads,
};

function tick() {
  for (const e in activeThreads) {
    activeThreads[e].run();
  }
  requestAnimationFrame(tick);
}

function addThread(...args) {
  const e = args.length <= 0 || undefined === args[0] ? ++uuid : args[0];

  const t = args.length <= 1 || undefined === args[1] ? {} : args[1];
  if (activeThreads[e] || idleThreads[e])
    throw new Error(`Thread with ID ${e} already exists.`);
  const i = new Thread(e, t);
  return (activeThreads[e] = i), i;
}

class Thread {
  #id;
  #mspf;
  #frame;
  #tasks;
  #simulate;
  #previousRun;
  #resetOnThrottle;

  resetFrame() {
    this.#frame = 0;
  }

  destroy() {
    delete activeThreads[this.#id];
  }

  play() {
    (this.#previousRun = +new Date()),
      (activeThreads[this.#id] = this),
      delete idleThreads[this.#id];
  }

  pause() {
    idleThreads[this.#id] = this;
    delete activeThreads[this.#id];
  }

  addTask(newTask) {
    this.#tasks.add(newTask);
  }

  removeTask(taskToRemove) {
    this.#tasks.delete(taskToRemove);
  }

  run(runCount = 0) {
    const dateNow = Date.now();

    if (!this.#simulate || dateNow > this.#previousRun) {
      this.#tasks.forEach((task) => {
        task(this);
      });
      this.#frame += 1;
    }

    if (!this.#simulate) {
      this.#previousRun = dateNow;
    } else if (this.#simulate && dateNow > this.#previousRun) {
      this.#previousRun += this.#mspf;

      if (runCount < maxRunCount) {
        this.run(runCount + 1);
      } else if (this.#resetOnThrottle) {
        this.#previousRun = dateNow;
      }
    }
  }

  set fps(newFps) {
    this.#mspf = 1e3 / newFps;
  }

  get frame() {
    return this.#frame;
  }

  constructor(spinnerName, options) {
    this.#id = spinnerName;
    this.#mspf = undefined === options.fps ? 1e3 / 60 : 1e3 / options.fps;
    this.#frame = undefined === options.frame ? 0 : options.frame;
    this.#simulate = undefined === options.simulate ? true : options.simulate;
    this.#resetOnThrottle =
      undefined === options.resetOnThrottle ? true : options.resetOnThrottle;
    this.#tasks =
      undefined === options.tasks ? new Set() : new Set(options.tasks);

    this.#previousRun = +new Date();
  }
}

tick();
