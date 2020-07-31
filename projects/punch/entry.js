import { board } from './canvas.js';
import { threadRunner } from './thread-runner.js';
import { addDown, addUp, fireKeyUp, fireKeyDown } from './keyboard.js';

const mainThread = threadRunner.addThread();
const modifiers = [];
window.addEventListener('blur', () => mainThread.pause());
window.addEventListener('focus', () => mainThread.play());

const envMult = 0.1;
const v = num => num * envMult;
const gravity = v(0.5);

const controlButtons = {
  Up: document.querySelector('.controls .jump'),
  Left: document.querySelector('.controls .left'),
  Right: document.querySelector('.controls .right'),
};
Object.entries(controlButtons).forEach(([name, element]) => {
  element.addEventListener('touchstart', (e) => {
    e.preventDefault();
    fireKeyDown(`Arrow${name}`);
  });
  element.addEventListener('touchend', (e) => {
    e.preventDefault();
    fireKeyUp(`Arrow${name}`);
  });
});

function addModifer(name, callback, { priority = 0 } = {}) {
  modifiers[priority] || (modifiers[priority] = {});
  modifiers[priority][name] = callback;
};

function removeModifer(name, { priority = 0 } = {}) {
  modifiers[priority] && delete modifiers[priority][name];
};

class Item {
  constructor ({ sprite, position, speed, data }) {
    const item = this;
    this.position = {
      ...position,
    };

    this.sprite = {
      ...sprite,
      cogX: sprite.cogX ?? 0,
      cogY: sprite.cogY ?? 0,
      get top() {
        return item.position.y - item.sprite.cogY;
      },
      set top(newTop) {
        item.y = newTop + item.sprite.cogY;
      },
      get bottom() {
        return item.position.y + item.sprite.height - item.sprite.cogY;
      },
      set bottom(newBottom) {
        item.y = newBottom + item.sprite.cogY - item.sprite.height;
      },
      get left() {
        return item.position.x - item.sprite.cogX;
      },
      set left(newLeft) {
        item.x = newLeft + item.sprite.cogX;
      },
      get right() {
        return item.position.x + item.sprite.width - item.sprite.cogX;
      },
      set right(newRight) {
        item.x = newRight + item.sprite.cogX - item.sprite.width;
      },
    };

    if (speed) {
      this.speed = speed;
      this.isStatic = false;
    } else {
      this.isStatic = true;
    }
    if (data) {
      this.data = data;
    }
  }

  goesLeftOf(x) {
    return this.sprite.left < x;
  }

  goesRightOf(x) {
    return this.sprite.right > x;
  }

  goesAbove(y) {
    return this.sprite.top < y;
  }

  goesBelow(y) {
    return this.sprite.bottom > y;
  }

  isLeftOf(x) {
    return this.sprite.right < x;
  }

  isRightOf(x) {
    return this.sprite.left > x;
  }

  isAbove(y) {
    return this.sprite.bottom < y;
  }

  isBelow(y) {
    return this.sprite.top > y;
  }

  goesWithinX(x, dx) {
    return this.sprite.left > x && this.sprite.left < x + dx
      || this.sprite.right > x && this.sprite.right < x + dx;
  }

  goesWithinY(y, dy) {
    return this.sprite.top > y && this.sprite.top < y + dy
      || this.sprite.bottom > x && this.sprite.right < x + dx;
  }

  isWithinX(x, dx) {
    return this.sprite.left > x && this.sprite.left < x + dx
      && this.sprite.right > x && this.sprite.right < x + dx;
  }

  isWithinY(y, dy) {
    return this.sprite.top > y && this.sprite.top < y + dy
      && this.sprite.bottom > x && this.sprite.right < x + dx;
  }

  multiplySpeedX(amount) {
    this.speed.x = this.speed.maxX
      ? Math.max(-this.speed.maxX, Math.min(this.speed.maxX, this.speed.x * amount))
      : this.speed.x * amount;
  }

  multiplySpeedY(amount) {
    this.speed.y = this.speed.maxY
      ? Math.max(-this.speed.maxY, Math.min(this.speed.maxY, this.speed.y * amount))
      : this.speed.y * amount;
  }

  addSpeedX(amount) {
    this.speed.x = this.speed.maxX
      ? Math.max(-this.speed.maxX, Math.min(this.speed.maxX, this.speed.x + amount))
      : this.speed.x + amount;
  }

  addSpeedY(amount) {
    this.speed.y = this.speed.maxY
      ? Math.max(-this.speed.maxY, Math.min(this.speed.maxY, this.speed.y + amount))
      : this.speed.y + amount;
  }

  simFrame() {
    this.position.x += this.speed.x;
    this.position.y += this.speed.y;
  }
}

const g = v(900); // ground
const char = new Item({
  sprite: {
    width: v(20),
    height: v(20),
    cogX: v(10),
    cogY: v(20),
    color: 'red',
  },

  position: {
    x: v(500),
    y: g,
  },

  speed: {
    x: v(0),
    y: v(0),
    maxX: v(40),
    maxY: v(100),
    accX: v(0.15),
  },

  data: {
    jumpCount: 0,
    maxJumps: 2,
    jumpTimeout: 0,
    jumpPower: v(7),
    bounciness: 0.5,
  },
});

const floor = new Item({
  sprite: {
    width: 100,
    height: 100 - g,
    color: 'blue',
  },

  position: {
    x: v(0),
    y: g,
  },
});

const board = new Item({
  sprite: {
    width: 100,
    height: 100 - g,
  },

  position: {
    x: 0,
    y: 0,
  },
});

const items = {
  char,
  floor,
};

addModifer('charGravity',  () => {
  if (char.sprite.bottom === g && char.speed.y === v(0)) { return; }
  char.addSpeedY(gravity);
});
addDown('ArrowLeft', () => {
  addModifer('charMoveLeft',  () => {
    char.addSpeedX(-char.speed.accX);
  });
});
addDown('ArrowRight', () => {
  addModifer('charMoveRight',  () => {
    char.addSpeedX(char.speed.accX);
  });
});
addDown('ArrowUp', () => {
  addModifer('charJump',  () => {
    if (
      char.data.jumpCount < char.data.maxJumps
    ) {
      if (char.sprite.bottom > v(g - 2)) {
        char.data.jumpCount += 1;
      } else if (char.data.maxJumps > 1) {
        if (char.data.jumpCount === 0) {
          char.data.jumpCount += 1;
        }
        char.data.jumpCount += 1;
      }
      char.addSpeedY(-char.data.jumpPower);
    }
    removeModifer('charJump');
  });
});

addModifer('friction', () => {
  Object.values(items).forEach(item => {
    if (item.isStatic) { return; }
    item.multiplySpeedX(0.95);
    item.multiplySpeedY(0.95);
  });
}, { priority: 10 });

addModifer('sim', () => Object.values(items).forEach(item => {
  Object.values(items).forEach((item) => {
    if (item.isStatic) { return; }
    item.simFrame();
  });
}), { priority: 20 });

addModifer('charBounceX',  () => {
  if (char.goesLeftOf(0)) {
    char.sprite.left = char.sprite.left * -char.data.bounciness;
    char.multiplySpeedX(-char.data.bounciness);
    char.addSpeedX(char.speed.accX);
  } else if (char.goesRightOf(100)) {
    const over = char.sprite.right - 100;
    char.sprite.right = 100 - over * char.data.bounciness;
    char.multiplySpeedX(-char.data.bounciness);
    char.addSpeedX(-char.speed.accX);
  }
}, { priority: 30 });

addModifer('charBounceY',  () => {
  if (char.goesBelow(g)) {
    const over = char.position.y - g;
    char.position.y = g - over * char.data.bounciness;
    char.multiplySpeedY(-char.data.bounciness);
    char.multiplySpeedX(char.data.bounciness);
    char.data.jumpCount = 0;
  }

  if (
    char.position.y < g + v(2)
    && char.position.y > g - v(2)
    && Math.abs(char.speed.y) < v(0.5)
  ) {
    char.position.y = g;
    char.multiplySpeedY(0);
  }
}, { priority: 30 });

addUp('ArrowLeft', () => {
  removeModifer('charMoveLeft');
});
addUp('ArrowRight', () => {
  removeModifer('charMoveRight');
});

mainThread.addTask(runModifiers);
renderAtScreenHz();

function runModifiers() {
  modifiers.forEach(modifierGroup => {
    Object.values(modifierGroup).forEach(modifier => modifier());
  });
}

function renderAtScreenHz() {
  requestAnimationFrame(() => {
    renderItems();
    renderAtScreenHz();
  });
}

function renderItems() {
  board.clear();
  Object.values(items).forEach(({sprite: {width, height, left, top, color}}) => {
    board.fillRect(left, top, width, height, color);
  });
}
