/**
*  @typedef thread
*  @type {Object}
*
*  @property {number}   fps      - The number of times this threads' tasks run every second
*  @property {boolean}  active   - Whether or not this thread should currently be running its tasks
*  @property {array}    tasks    - An array of functions, or 'tasks', this thread will run every 'tick'
*/

/**
*  Returns a threadRunner object. This is used for running 'simulations', or 'multi-run-functions' a certain number of times per second in a way which setTimeout cannot guarantee.
*  @function
*  @name createThreadRunner
*  @returns {threadRunner} threadRunner
*/

const activeThreads = {};
const idleThreads   = {};
export const threadRunner  = {
  addThread,
  __activeThreads: activeThreads,
  __idleThreads:   idleThreads,
};

let uuid = 0;
tick();

function tick() {
  for (let i in activeThreads) {
    activeThreads[i].run()
  }

  requestAnimationFrame(tick);
}

function addThread ( newThreadID = ++uuid, options = {} ) {
  if (activeThreads[newThreadID] || idleThreads[newThreadID]) {
    throw new Error(`Thread with ID ${newThreadID} already exists.`);
  }
  const thread = new Thread(newThreadID, options);
  activeThreads[ newThreadID ] = thread;
  return thread;
}

class Thread {
  #frame;
  #atTime;

  constructor (id, { fps = 60, active = false, tasks = [], frame = 0, simulate = true } = {}) {
    this.#frame = frame;
    this.#atTime = +new Date();
    this.id = id;
    this.fps = fps;
    this.active = active;
    this.tasks = tasks;
    this.simulate = simulate;

    this.removeTask = task => {
      const taskIndex = this.tasks.indexOf(task);
      if (taskIndex > -1 ) {
        this.tasks.splice(taskIndex, 1);
      }
    }

    this.run = () => {
      const dateNow = +new Date();

      if (!this.simulate || this.#atTime < dateNow) {
        this.tasks.forEach(task => {
          task();
        });

        this.#atTime += 1000 / this.fps;
        this.#frame  += 1;

        if (this.simulate) {
          this.run();
        }
      }
    }
  }

  get frame() {
    return this.#frame;
  }

  get atTime() {
    return this.#atTime;
  }

  resetFrame() {
    this.#frame = 0;
  }

  destroy() {
    delete activeThreads[ this.id ];
  }

  play() {
    this.#atTime = +new Date();
    activeThreads[ this.id ] = this;
    delete idleThreads[ this.id ];
  }

  pause() {
    idleThreads[ this.id ] = this;
    delete activeThreads[ this.id ];
  }

  addTask = task => {
    if (this.tasks.indexOf(task) === -1 ) {
      this.tasks.push( task.bind(this) );
    }
  }
}
