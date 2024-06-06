const items = [
  { name: "Alan Z", image: "./i/Alan Z.jpg" },
  {
    name: "Arnaud Michel Jacques Lago",
    image: "./i/Arnaud Michel Jacques Lago.jpg",
  },
  { name: "Brandon Jie Yi Lam", image: "./i/Brandon Jie Yi Lam.jpg" },
  { name: "Brandon Ong", image: "./i/Brandon Ong.png" },
  { name: "Brook Jordan", image: "./i/Brook Jordan.jpg" },
  { name: "Cong Vu", image: "./i/Cong Vu.jpg" },
  { name: "Eduard Nabokov", image: "./i/Eduard Nabokov.jpg" },
  { name: "Fil Mihaylov", image: "./i/Fil Mihaylov.png" },
  { name: "Hung Viet Nguyen", image: "./i/Hung Viet Nguyen.jpg" },
  { name: "Ivan Petkov", image: "./i/Ivan Petkov.jpg" },
  { name: "Jingchen Yu", image: "./i/Jingchen Yu.jpg" },
  { name: "Kakali Basak", image: "./i/Kakali Basak.jpg" },
  { name: "Katya Daskalova", image: "./i/Katya Daskalova.jpg" },
  { name: "Kenny Reida Dharmawan", image: "./i/Kenny Reida Dharmawan.png" },
  {
    name: "Marcellus Reinaldo Jodihardja",
    image: "./i/Marcellus Reinaldo Jodihardja.jpg",
  },
  { name: "Marco Mandrioli", image: "./i/Marco Mandrioli.jpg" },
  { name: "Matt Yang", image: "./i/Matt Yang.jpg" },
  { name: "Minsung Cho", image: "./i/Minsung Cho.jpg" },
  { name: "Namith", image: "./i/Namith.jpg" },
  { name: "Nicholas Tan Xuan", image: "./i/Nicholas Tan Xuan.jpg" },
  { name: "Olzhas Kaiyrakhmet", image: "./i/Olzhas Kaiyrakhmet.jpg" },
  { name: "Panteley Boyadjiev", image: "./i/Panteley Boyadjiev.jpg" },
  { name: "Plamen", image: "./i/Plamen.png" },
  { name: "Quanjie Yang", image: "./i/Quanjie Yang.jpg" },
  { name: "Rajnish Kumar", image: "./i/Rajnish Kumar.png" },
  { name: "Robin Yeh", image: "./i/Robin Yeh.jpg" },
  {
    name: "Sadaananth Anbucheliyan",
    image: "./i/Sadaananth Anbucheliyan.png",
  },
  { name: "Sarah Neo", image: "./i/Sarah Neo.jpg" },
  { name: "Sergei Stepanov", image: "./i/Sergei Stepanov.jpg" },
  { name: "Shen Rui Chong", image: "./i/Shen Rui Chong.jpg" },
  { name: "Stacey Ng", image: "./i/Stacey Ng.jpg" },
  {
    name: "Thanh Tam Hoang",
    image: "./i/Thanh Tam Hoang.jpg",
  },
  { name: "Tian Fu Tan", image: "./i/Tian Fu Tan.jpg" },
  { name: "Tudor Gergely", image: "./i/Tudor Gergely.jpg" },
  { name: "Wan Jou Lim", image: "./i/Wan Jou Lim.jpg" },
  {
    name: "Wee Kiat Clarence Ang",
    image: "./i/Wee Kiat Clarence Ang.jpg",
  },
  { name: "Wei Jian Chen", image: "./i/Wei Jian Chen.jpg" },
  {
    name: "William Kar Hoong Yoong",
    image: "./i/William Kar Hoong Yoong.jpg",
  },
  {
    name: "Zizhang Ai",
    image: "./i/Zizhang Ai.jpg",
  },
];

const DEFAULT_INITIAL_POSITION = 0;
const DEFAULT_INITIAL_VELOCITY = 10;
const DEFAULT_FRICTION = 0.01;

function willBeAt(
  frameNumber,
  {
    initialPosition = DEFAULT_INITIAL_POSITION,
    initialVelocity = DEFAULT_INITIAL_VELOCITY,
    friction = DEFAULT_FRICTION,
  } = {}
) {
  return (
    initialPosition +
    initialVelocity * ((1 - (1 - friction) ** frameNumber) / friction)
  );
}

function willLandAt({
  initialPosition = DEFAULT_INITIAL_POSITION,
  initialVelocity = DEFAULT_INITIAL_VELOCITY,
  friction = DEFAULT_FRICTION,
} = {}) {
  return initialPosition + initialVelocity / friction;
}

function frictionRequiredToLandAt({
  initialPosition = DEFAULT_INITIAL_POSITION,
  initialVelocity = DEFAULT_INITIAL_VELOCITY,
  finalLanding = DEFAULT_FRICTION,
}) {
  return initialVelocity / (finalLanding - initialPosition);
}

function average(...numbers) {
  return numbers.length < 1
    ? 0
    : numbers.length < 2
    ? numbers[0]
    : numbers.reduce((e, r) => (e + r) / 2);
}

const cursorSpeeds = [];
const _document = document;
const body$2 = _document.body;
let prevClientY = undefined;
let clientY = undefined;

function initialiseCursorTracking() {
  body$2.addEventListener("mousemove", mouseSpeed, false);
  body$2.addEventListener("touchmove", mouseSpeed, false);
  body$2.addEventListener("touchstart", mouseSpeed, false);
  body$2.addEventListener("touchend", mouseSpeed, false);
  checkCursorSpeed();
}

function getY(event) {
  return (event.touches ? event.touches[0].pageY : event.clientY);
}

function getX(event) {
  return (event.touches ? event.touches[0].pageX : event.clientX);
}

function resetCursorSpeed(event) {
  for (; cursorSpeeds.length; ) cursorSpeeds.pop();
  clientY = prevClientY = getY(event);
}

function cursorSpeed() {
  return average.apply(undefined, cursorSpeeds);
}

function checkCursorSpeed() {
  addMousePositionToStack(), requestAnimationFrame(checkCursorSpeed);
}

function addMousePositionToStack() {
  if ("number" == typeof clientY) {
    "number" == typeof prevClientY || (prevClientY = clientY);
    cursorSpeeds.push(clientY - prevClientY);
    cursorSpeeds.length > 5 && cursorSpeeds.unshift();
    prevClientY = clientY;
  }
}

function mouseSpeed(e) {
  clientY = getY(e);
  getX(e);
}

const maxRunCount = 2 ** 10;
let activeThreads = {};
let idleThreads = {};
let uuid = 0;

const threadRunner = {
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

const body$1 = document.body;
const nameCards = [];
const spinThread = threadRunner.addThread("spinner-sim", {
  fps: 60,
  simulate: true,
});
const renderThread = threadRunner.addThread("spinner-render", {
  simulate: false,
});

spinThread.addTask(keepSpinning);
renderThread.addTask(updateDOM);

let showEasySpinTimeout;
let checkboxContainer = null;
let togglesToggle = null;
let spinnerStartSpeed = 0;
let spinnerStartPos = 0;
let spinnerSpeed = 0;
let spinnerPos = 0;
let cards = null;
let lastY = null;
let requestedFriction = null;
let frict = null;
let nameCount = null;
let spinnerElt$1 = null;
let defaultNameFilter = null;
let nameFilter = null;
let nameFilterStorage = "nameFilter";

function enableTrackMouse(event) {
  if (event.target.closest(".lazy-spin-button")) {
    return;
  }

  event.preventDefault();

  resetCursorSpeed(event);
  spinThread.pause();
  if (body$1.classList) {
    body$1.classList.add("grabbing");
  }
  spinnerSpeed = 0;
  lastY = getY(event);

  body$1.addEventListener("mousemove", trackMouse, !1);
  body$1.addEventListener("touchmove", trackMouse, !1);
  body$1.addEventListener("mouseup", startSpinnerSpinning, !1);
  body$1.addEventListener("touchend", startSpinnerSpinning, !1);
  body$1.addEventListener("touchcancel", startSpinnerSpinning, !1);
}

function disableTrackMouse(event) {
  event.preventDefault();

  if (body$1.classList) {
    document.body.classList.remove("grabbing");
  }
  lastY = null;
  body$1.removeEventListener("mousemove", trackMouse, !1);
  body$1.removeEventListener("touchmove", trackMouse, !1);
  body$1.removeEventListener("mouseup", startSpinnerSpinning, !1);
  body$1.removeEventListener("touchend", startSpinnerSpinning, !1);
  body$1.removeEventListener("touchcancel", startSpinnerSpinning, !1);
}

function startSpinnerSpinning(event, customSpeed) {
  event.preventDefault();
  spinnerStartPos = spinnerPos;
  spinnerStartSpeed = spinnerSpeed =
    typeof customSpeed === "number" ? customSpeed : px2spd(cursorSpeed());

  if (showEasySpinTimeout && spinnerStartSpeed > 0.07 || spinnerSpeed < -0.07) {
    clearTimeout(showEasySpinTimeout);
  }

  const calculatedLandingSpot = willLandAt({
    initialPosition: spinnerStartPos,
    initialVelocity: spinnerStartSpeed,
    friction: requestedFriction,
  });

  const integerLandingSpot =
    spinnerSpeed > 0
      ? Math.ceil(calculatedLandingSpot)
      : Math.floor(calculatedLandingSpot);
  frict = frictionRequiredToLandAt({
    initialPosition: spinnerStartPos,
    initialVelocity: spinnerStartSpeed,
    finalLanding: integerLandingSpot,
  });

  disableTrackMouse(event);
  startSpinning();
}

function simulateSpin(frameNumber) {
  if (nameCards.length) {
    spinnerPos = willBeAt(frameNumber, {
      initialPosition: spinnerStartPos,
      initialVelocity: spinnerStartSpeed,
      friction: frict,
    });
  }
}

function keepSpinning({ frame }) {
  if (spinnerSpeed) {
    simulateSpin(frame);
  } else {
    spinThread.pause();
  }
}

function startSpinning() {
  spinThread.resetFrame();
  spinThread.play();
}

function updateDOM() {
  killFallenNames();
  buildNames();
  renderNames();
}

function trackMouse(event) {
  event.preventDefault();

  const n = getY(event);
  spinnerPos += px2spd(n - lastY);
  lastY = n;
  updateDOM();
}

function px2spd(px) {
  return (px / innerHeight) * nameCount;
}

function cardPosition({ index }) {
  return (spinnerPos + index) / nameCount;
}

function maxPos() {
  return nameCards.length
    ? Math.max(...nameCards.map((e) => cardPosition(e)))
    : null;
}

function maxIndex() {
  return nameCards.length
    ? Math.max(...nameCards.map(({ index }) => index))
    : null;
}

function minPos() {
  return nameCards.length
    ? Math.min(...nameCards.map((card) => cardPosition(card)))
    : null;
}

function minIndex() {
  return nameCards.length
    ? Math.min(...nameCards.map(({ index }) => index))
    : null;
}

function buildNames() {
  for (0 === nameCards.length && addName(!0); minPos() > 0; ) {
    addName(!1);
  }
  for (; maxPos() < (nameCount - 1) / nameCount; ) {
    addName(!0);
  }
  renderNames();
}

function killName(card) {
  const cardIndex = nameCards.indexOf(card);
  nameCards.splice(cardIndex, 1)[0];
  if (card.elt.parentNode) {
    card.elt.remove();
  }
}

function killFallenNames() {
  if (
    minPos() < -1 / nameCount ||
    maxPos() > (1 / nameCount) * (nameCount - 1)
  ) {
    nameCards.forEach((card) => {
      const cardIndex = cardPosition(card);
      if (-1 / nameCount >= cardIndex || cardIndex >= 1) {
        killName(card);
      }
    });
  }
}

function renderName({ elt, index }) {
  elt.style.setProperty(
    "--y",
    (spinnerPos + index).toFixed(3)
  );
}

function renderNames() {
  nameCards.forEach((card) => {
    renderName(card);
  });
}

function addName(cardName = false) {
  const filteredCards = (
    nameFilter
      ? cards.filter(({ name }) => nameFilter.includes(name))
      : [...cards]
  ).sort((cardA, cardB) => cardA.name.localeCompare(cardB.name));
  const unusedCards = filteredCards.filter(({ name }) =>
    nameCards.every(({ text }) => text.name !== name),
  );

  const randomPerson =
    unusedCards[Math.floor(Math.random() * unusedCards.length)];
  const index =
    nameCards.length === 0 ? 0 : cardName ? maxIndex() + 1 : minIndex() - 1;

  const cardElt = document.createElement("div");
  cardElt.className = "name";

  const labelWrapperElt = document.createElement("p");
  labelWrapperElt.className = "name__text-wrapper";

  const labelElt = document.createElement("span");
  labelElt.className = "name__text";

  // I’m not sure why random person sometimes doensn’t exist
  if (randomPerson) {
    cardElt.style.setProperty(
      "--i-bg",
      randomPerson.image ? `url("../${randomPerson.image}")` : "none",
    );
    labelElt.innerHTML = (randomPerson && randomPerson.name) || "";
  }

  cardElt.append(labelWrapperElt);
  labelWrapperElt.append(labelElt);
  spinnerElt$1.append(cardElt);

  nameCards.push({ text: randomPerson, index: index, elt: cardElt });
}

function setNameCount(desiredNewCount) {
  nameCount = Math.min(15, desiredNewCount, Math.round(cards.length / 2));
}

function initialiseSpinner(
  _spinnerElt,
  _cards,
  {
    friction = 0.01,
    desiredNameCount = 5,
    initialItemNames = _cards.map(({ name }) => name),
  } = {},
) {
  cards = _cards;
  spinnerElt$1 = _spinnerElt;
  requestedFriction = friction;
  setNameCount(desiredNameCount);
  defaultNameFilter = initialItemNames;

  if (localStorage.getItem(nameFilterStorage)) {
    nameFilter = JSON.parse(localStorage.getItem(nameFilterStorage));
  } else {
    nameFilter = defaultNameFilter;
  }

  buildNames();
  initialiseCursorTracking();

  body$1.addEventListener("mousedown", enableTrackMouse, !1);
  body$1.addEventListener("touchstart", enableTrackMouse, !1);

  document.body.style.setProperty("--name-count", nameCount);

  checkboxContainer = createCheckboxControls();
  showEasySpinTimeout = setTimeout(() => {
    createEasySpinnerButton();
  }, 10000);
}

function createEasySpinnerButton() {
  const button = document.createElement("button");
  button.className = "lazy-spin-button";
  button.textContent = "LAZY SPIN";
  button.title = "Click and drag to spin the wheel";
  button.addEventListener("mousedown", (event) => {
    const baseSpeed = Math.random() * 0.4 - 0.2;
    startSpinnerSpinning(event, baseSpeed + Math.sign(baseSpeed) * 0.15);
    spinThread.play();
  });
  document.body.append(button);
}

function createCheckboxControls() {
  togglesToggle = document.createElement("button");
  togglesToggle.className = "checkbox-toggle";
  togglesToggle.addEventListener("click", toggleCheckboxContainer);
  togglesToggle.addEventListener("touchstart", toggleCheckboxContainer);
  document.body.append(togglesToggle);

  const wrapper = document.createElement("div");
  wrapper.className = "checkbox-wrapper";

  const container = document.createElement("div");
  container.className = "checkbox-container";
  container.id = "checkbox_container";

  cards.forEach(({ name, image }) => {
    const checkbox = document.createElement("input");
    checkbox.type = "checkbox";
    checkbox.name = name;
    checkbox.value = name;
    checkbox.id = `spinner-checkbox-${name.replace(/\s+/g, "-")}`;
    checkbox.checked = nameFilter.includes(name);
    checkbox.addEventListener("change", (event) => {
      if (event.target.checked) {
        nameFilter.push(name);
      } else {
        nameFilter.splice(nameFilter.indexOf(name), 1);
      }
      localStorage.setItem(nameFilterStorage, JSON.stringify(nameFilter));
    });

    const label = document.createElement("label");
    const labelText = document.createTextNode(name);
    const img = new Image();
    img.src = image;
    label.setAttribute("for", `spinner-checkbox-${name.replace(/\s+/g, "-")}`);
    label.append(checkbox, img, labelText);

    wrapper.appendChild(label);
  });

  const resetButton = document.createElement("button");
  resetButton.textContent = "Reset to default";
  resetButton.className = "checkbox-reset";
  resetButton.addEventListener("click", () => {
    nameFilter = defaultNameFilter;
    localStorage.removeItem(nameFilterStorage);
    Array.from(wrapper.querySelectorAll("input")).forEach((input) => {
      input.checked = nameFilter.includes(input.name);
    });
  });
  wrapper.appendChild(resetButton);
  container.appendChild(wrapper);

  return container;
}

function toggleCheckboxContainer() {
  if (document.body.contains(checkboxContainer)) {
    togglesToggle.setAttribute("aria-expanded", "false");
    togglesToggle.setAttribute("aria-controls", "");

    checkboxContainer.remove();
  } else {
    document.body.append(checkboxContainer);

    togglesToggle.setAttribute("aria-expanded", "true");
    togglesToggle.setAttribute("aria-controls", "checkbox_container");
  }
}
function handleKeyDown(event) {
  if (event.key !== "Escape") return;
  toggleCheckboxContainer();
}
window.addEventListener("keydown", handleKeyDown);

function getDesiredCount() {
  return +new URLSearchParams(location.search).get("count") || 5;
}

const body = document.body;
const spinnerElt = document.createElement("div");

const peopleInDemo = [
  "Brook Jordan",
  "Cong Vu",
  "Jingchen Yu",
  "Kenny Reida Dharmawan",
  "Marcellus Reinaldo Jodihardja",
  "Nicholas Tan Xuan",
  "Robin Yeh",
  "Stacey Ng",
  "Tian Fu Tan",
  "Wee Kiat Clarence Ang",

  // "Alan Z",
  // "Arnaud Michel Jacques Lago",
  // "Brandon Jie Yi Lam",
  // "Brandon Ong",
  // "Eduard Nabokov",
  // "Fil Mihaylov",
  // "Hung Viet Nguyen",
  // "Ivan Petkov",
  // "Kakali Basak",
  // "Katya Daskalova",
  // "Marco Mandrioli",
  // "Matt Yang",
  // "Minsung Cho",
  // "Namith",
  // "Olzhas Kaiyrakhmet",
  // "Panteley Boyadjiev",
  // "Plamen",
  // "Quanjie Yang",
  // "Rajnish Kumar",
  // "Sadaananth Anbucheliyan",
  // "Sarah Neo",
  // "Sergei Stepanov",
  // "Shen Rui Chong",
  // "Thanh Tam Hoang",
  // "Tudor Gergely",
  // "Wan Jou Lim",
  // "Wei Jian Chen",
  // "William Kar Hoong Yoong",
  // "Zizhang Ai",
];

body.appendChild(spinnerElt);
initialiseSpinner(spinnerElt, items, {
  desiredNameCount: getDesiredCount(),
  friction: 0.01,
  initialItemNames: peopleInDemo,
});
