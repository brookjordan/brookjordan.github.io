(function e(t, n, r) {
  function s(o, u) {
    if (!n[o]) {
      if (!t[o]) {
        var a = typeof require == "function" && require;
        if (!u && a) return a(o, !0);
        if (i) return i(o, !0);
        var f = new Error("Cannot find module '" + o + "'");
        throw ((f.code = "MODULE_NOT_FOUND"), f);
      }
      var l = (n[o] = { exports: {} });
      t[o][0].call(
        l.exports,
        function (e) {
          var n = t[o][1][e];
          return s(n ? n : e);
        },
        l,
        l.exports,
        e,
        t,
        n,
        r
      );
    }
    return n[o].exports;
  }
  var i = typeof require == "function" && require;
  for (var o = 0; o < r.length; o++) s(r[o]);
  return s;
})(
  {
    1: [
      function (require, module, exports) {
        "use strict";
        Object.defineProperty(exports, "__esModule", { value: !0 }),
          (exports["default"] = [
            { name: "Alan Z", image: "./i/Alan Z.jpg" },
            {
              name: "Arnaud Michel Jacques Lago",
              image: "./i/Arnaud Michel Jacques Lago.jpg",
            },
            { name: "Brandon Jie Yi Lam", image: "./i/Brandon Jie Yi Lam.jpg" },
            { name: "Brandon Ong", image: "./i/Brandon Ong.png" },
            { name: "Brook Jordan", image: "./i/Brook Jordan.png" },
            { name: "Eduard Nabokov", image: "./i/Eduard Nabokov.jpg" },
            { name: "Fil Mihaylov", image: "./i/Fil Mihaylov.png" },
            { name: "Hung Viet Nguyen", image: "./i/Hung Viet Nguyen.png" },
            { name: "Ivan Petkov", image: "./i/Ivan Petkov.png" },
            { name: "Kakali Basak", image: "./i/Kakali Basak.jpg" },
            { name: "Katya Daskalova", image: "./i/Katya Daskalova.png" },
            {
              name: "Marcellus Reinaldo Jodihardja",
              image: "./i/Marcellus Reinaldo Jodihardja.jpg",
            },
            { name: "Marco Mandrioli", image: "./i/Marco Mandrioli.jpg" },
            { name: "Minsung Cho", image: "./i/Minsung Cho.png" },
            { name: "Namith", image: "./i/Namith.png" },
            { name: "Nicholas Tan Xuan", image: "./i/Nicholas Tan Xuan.jpg" },
            { name: "Olzhas Kaiyrakhmet", image: "./i/Olzhas Kaiyrakhmet.jpg" },
            { name: "Panteley Boyadjiev", image: "./i/Panteley Boyadjiev.jpg" },
            { name: "Plamen", image: "./i/Plamen.png" },
            { name: "Quanjie Yang", image: "./i/Quanjie Yang.jpg" },
            { name: "Robin Yeh", image: "./i/Robin Yeh.jpg" },
            {
              name: "Sadaananth Anbucheliyan",
              image: "./i/Sadaananth Anbucheliyan.png",
            },
            { name: "Sarah Neo", image: "./i/Sarah Neo.jpg" },
            { name: "Sergei Stepanov", image: "./i/Sergei Stepanov.png" },
            { name: "Shen Rui Chong", image: "./i/Shen Rui Chong.jpg" },
            { name: "Stacey Ng", image: "./i/Stacey Ng.png" },
            {
              name: "Thanh Tam Hoang",
              image: "./i/Thanh Tam Hoang.png",
            },
            { name: "Tian Fu Tan", image: "./i/Tian Fu Tan.jpg" },
            { name: "Tudor Gergely", image: "./i/Tudor Gergely.jpg" },
            { name: "Wan Jou Lim", image: "./i/Wan Jou Lim.jpg" },
            {
              name: "Wee Kiat Clarence Ang",
              image: "./i/Wee Kiat Clarence Ang.jpg",
            },
            { name: "Wei Jian Chen", image: "./i/Wei Jian Chen.png" },
            {
              name: "William Kar Hoong Yoong",
              image: "./i/William Kar Hoong Yoong.png",
            },
          ]);
      },
      {},
    ],
    2: [
      function (require, module, exports) {
        "use strict";
        function _interopRequireDefault(e) {
          return e && e.__esModule ? e : { default: e };
        }
        function getDesiredCount(e) {
          return 4;
        }
        var _people = require("../data/people.js"),
          _people2 = _interopRequireDefault(_people),
          _spinner = require("../method/spinner.js"),
          _spinner2 = _interopRequireDefault(_spinner),
          body = document.body,
          spinnerElt = document.createElement("div");
        body.appendChild(spinnerElt),
          (0, _spinner2["default"])(spinnerElt, _people2["default"], {
            desiredNameCount: getDesiredCount(),
            friction: 0.01,
          });
      },
      { "../data/people.js": 1, "../method/spinner.js": 5 },
    ],
    3: [
      function (require, module, exports) {
        "use strict";
        function average() {
          for (var e = arguments.length, r = Array(e), t = 0; e > t; t++)
            r[t] = arguments[t];
          return r.length < 1
            ? 0
            : r.length < 2
            ? r[0]
            : r.reduce(function (e, r) {
                return (e + r) / 2;
              });
        }
        Object.defineProperty(exports, "__esModule", { value: !0 }),
          (exports.average = average),
          (exports["default"] = { average: average });
      },
      {},
    ],
    4: [
      function (require, module, exports) {
        "use strict";
        function willBeAt(i) {
          var t =
              arguments.length <= 1 || void 0 === arguments[1]
                ? {}
                : arguments[1],
            o = t.initialPosition,
            n = void 0 === o ? 0 : o,
            e = t.initialVelocity,
            l = void 0 === e ? 10 : e,
            d = t.friction,
            r = void 0 === d ? 0.01 : d;
          return n + l * ((1 - Math.pow(1 - r, i)) / r);
        }
        function willLandAt() {
          var i =
              arguments.length <= 0 || void 0 === arguments[0]
                ? {}
                : arguments[0],
            t = i.initialPosition,
            o = void 0 === t ? 0 : t,
            n = i.initialVelocity,
            e = void 0 === n ? 10 : n,
            l = i.friction,
            d = void 0 === l ? 0.01 : l;
          return o + e / d;
        }
        function frictionRequiredToLandAt() {
          var i =
              arguments.length <= 0 || void 0 === arguments[0]
                ? {}
                : arguments[0],
            t = i.initialPosition,
            o = void 0 === t ? 0 : t,
            n = i.initialVelocity,
            e = void 0 === n ? 10 : n,
            l = i.finalLanding,
            d = void 0 === l ? 1e3 : l;
          return e / (d - o);
        }
        Object.defineProperty(exports, "__esModule", { value: !0 }),
          (exports.willBeAt = willBeAt),
          (exports.willLandAt = willLandAt),
          (exports.frictionRequiredToLandAt = frictionRequiredToLandAt);
      },
      {},
    ],
    5: [
      function (require, module, exports) {
        "use strict";
        function _interopRequireDefault(e) {
          return e && e.__esModule ? e : { default: e };
        }
        function _toConsumableArray(e) {
          if (Array.isArray(e)) {
            for (var n = 0, r = Array(e.length); n < e.length; n++) r[n] = e[n];
            return r;
          }
          return Array.from(e);
        }
        function enableTrackMouse(e) {
          e.preventDefault(),
            (0, _trackCursor.resetCursorSpeed)(e),
            spinThread.pause(),
            body.classList && body.classList.add("grabbing"),
            (spinnerSpeed = 0),
            (lastY = (0, _trackCursor.getY)(e)),
            body.addEventListener("mousemove", trackMouse, !1),
            body.addEventListener("touchmove", trackMouse, !1);
        }
        function disableTrackMouse(e) {
          e.preventDefault(),
            body.classList && document.body.classList.remove("grabbing"),
            (lastY = void 0),
            body.removeEventListener("mousemove", trackMouse, !1),
            body.removeEventListener("touchmove", trackMouse, !1);
        }
        function startSpinnerSpinning(e) {
          e.preventDefault(),
            (frame = 1),
            (spinnerStartPos = spinnerPos),
            (spinnerStartSpeed = spinnerSpeed =
              px2spd((0, _trackCursor.cursorSpeed)()));
          var n = (0, _mechanics.willLandAt)({
              initialPosition: spinnerStartPos,
              initialVelocity: spinnerStartSpeed,
              friction: requestedFriction,
            }),
            r = spinnerSpeed > 0 ? Math.ceil(n) : Math.floor(n);
          (frict = (0, _mechanics.frictionRequiredToLandAt)({
            initialPosition: spinnerStartPos,
            initialVelocity: spinnerStartSpeed,
            finalLanding: r,
          })),
            disableTrackMouse(e),
            startSpinning();
        }
        function simulateSpin(e) {
          if (nameCards.length) {
            spinnerPos = (0, _mechanics.willBeAt)(e, {
              initialPosition: spinnerStartPos,
              initialVelocity: spinnerStartSpeed,
              friction: frict,
            });
          }
        }
        function keepSpinning() {
          if (spinnerSpeed) {
            simulateSpin(this.frame);
          } else {
            spinThread.pause();
          }
        }
        function startSpinning() {
          spinThread.resetFrame(), spinThread.play();
        }
        function updateDOM() {
          killNames(), buildNames(), renderNames();
        }
        function trackMouse(e) {
          e.preventDefault();
          var n = (0, _trackCursor.getY)(e);
          (spinnerPos += px2spd(n - lastY)), (lastY = n), updateDOM();
        }
        function px2spd(e) {
          return (e / innerHeight) * nameCount;
        }
        function cardPosition(e) {
          return (spinnerPos + e.index) / nameCount;
        }
        function maxPos() {
          return nameCards.length
            ? Math.max.apply(
                Math,
                _toConsumableArray(
                  nameCards.map(function (e) {
                    return cardPosition(e);
                  })
                )
              )
            : void 0;
        }
        function maxIndex() {
          return nameCards.length
            ? Math.max.apply(
                Math,
                _toConsumableArray(
                  nameCards.map(function (e) {
                    return e.index;
                  })
                )
              )
            : void 0;
        }
        function minPos() {
          return nameCards.length
            ? Math.min.apply(
                Math,
                _toConsumableArray(
                  nameCards.map(function (e) {
                    return cardPosition(e);
                  })
                )
              )
            : void 0;
        }
        function minIndex() {
          return nameCards.length
            ? Math.min.apply(
                Math,
                _toConsumableArray(
                  nameCards.map(function (e) {
                    return e.index;
                  })
                )
              )
            : void 0;
        }
        function buildNames() {
          for (0 === nameCards.length && addName(!0); minPos() > 0; )
            addName(!1);
          for (; maxPos() < (nameCount - 1) / nameCount; ) addName(!0);
          renderNames();
        }
        function killName(e) {
          var n = nameCards.indexOf(e);
          nameCards.splice(n, 1)[0],
            e.elt.parentNode && e.elt.parentNode.removeChild(e.elt),
            "undefined" != typeof e.text && cards.push(e.text);
        }
        function killNames() {
          (minPos() < -1 / nameCount ||
            maxPos() > (1 / nameCount) * (nameCount - 1)) &&
            nameCards.forEach(function (e, n) {
              var r = cardPosition(e);
              -1 / nameCount >= r && killName(e), r >= 1 && killName(e);
            });
        }
        function renderName(e) {
          e.elt.style.transform =
            "translateY(" + 100 * (spinnerPos + e.index) + "%)";
        }
        function renderNames() {
          nameCards.forEach(function (e) {
            renderName(e);
          });
        }
        function addName(e) {
          const unusedCards = cards.filter((card) =>
            nameCards.every((nameCard) => nameCard.text.name !== card.name)
          );
          var n = e || false,
            cardElt = document.createElement("div"),
            labelElt = document.createElement("p"),
            cardHeight = 100 / nameCount,
            randomPerson =
              unusedCards[Math.floor(Math.random() * unusedCards.length)],
            s =
              0 === nameCards.length ? 0 : n ? maxIndex() + 1 : minIndex() - 1;
          cardElt.className = "name";
          cardElt.style.height = cardHeight + "vh";
          cardElt.style.lineHeight = cardHeight + "vh";
          if (randomPerson.image) {
            const imageStyle = `url("${randomPerson.image}")`;
            cardElt.style.backgroundImage = imageStyle;
          } else {
            cardElt.style.backgroundImage = "none";
          }
          labelElt.innerHTML = randomPerson ? randomPerson.name || "" : "";
          labelElt.className = "name__text";
          labelElt.style.fontSize = Math.min(6, 40 / nameCount) + "vmin";
          cardElt.appendChild(labelElt);
          spinnerElt.appendChild(cardElt);
          nameCards.push({ text: randomPerson, index: s, elt: cardElt });
        }
        Object.defineProperty(exports, "__esModule", { value: !0 }),
          (exports["default"] = function (e, n) {
            var r =
                arguments.length <= 2 || void 0 === arguments[2]
                  ? {}
                  : arguments[2],
              t = r.desiredNameCount,
              a = void 0 === t ? 4 : t,
              i = r.friction,
              s = void 0 === i ? 0.01 : i;
            (cards = n),
              (spinnerElt = e),
              (requestedFriction = s),
              (nameCount = Math.min(a, Math.round(cards.length / 2))),
              (spinnerMaxSpeed = 100 * Math.floor(cards.length / 2)),
              buildNames(),
              (0, _trackCursor2["default"])(),
              body.addEventListener("mouseup", startSpinnerSpinning, !1),
              body.addEventListener("touchend", startSpinnerSpinning, !1),
              body.addEventListener("touchcancel", startSpinnerSpinning, !1),
              body.addEventListener("mousedown", enableTrackMouse, !1),
              body.addEventListener("touchstart", enableTrackMouse, !1);
          });
        var _mechanics = require("../method/mechanics.js"),
          _trackCursor = require("../method/track-cursor.js"),
          _trackCursor2 = _interopRequireDefault(_trackCursor),
          _threadRunner = require("../method/thread-runner.js"),
          _threadRunner2 = _interopRequireDefault(_threadRunner),
          body = document.body,
          nameCards = [],
          spinThread = _threadRunner2["default"].addThread("spinner-sim", {
            fps: 60,
          }),
          renderThread = _threadRunner2["default"].addThread("spinner-render", {
            fps: 60,
          });
        spinThread.addTask(keepSpinning), renderThread.addTask(updateDOM);
        var spinnerStartSpeed = 0,
          spinnerStartPos = 0,
          spinnerSpeed = 0,
          spinnerPos = 0,
          cards = void 0,
          frame = void 0,
          lastY = void 0,
          requestedFriction = void 0,
          frict = void 0,
          nameCount = void 0,
          spinnerMaxSpeed = void 0,
          spinnerElt = void 0;
      },
      {
        "../method/mechanics.js": 4,
        "../method/thread-runner.js": 6,
        "../method/track-cursor.js": 7,
      },
    ],
    6: [
      function (require, module, exports) {
        "use strict";
        function tick() {
          for (var e in activeThreads) activeThreads[e].run();
          requestAnimationFrame(tick);
        }
        function addThread() {
          var e =
              arguments.length <= 0 || void 0 === arguments[0]
                ? ++uuid
                : arguments[0],
            t =
              arguments.length <= 1 || void 0 === arguments[1]
                ? {}
                : arguments[1];
          if (activeThreads[e] || idleThreads[e])
            throw new Error("Thread with ID " + e + " already exists.");
          var i = new Thread(e, t);
          return (activeThreads[e] = i), i;
        }
        function Thread(e) {
          var t = this,
            i =
              arguments.length <= 1 || void 0 === arguments[1]
                ? {}
                : arguments[1],
            a = i.fps,
            r = void 0 === a ? 60 : a,
            d = (i.active, i.tasks),
            n = void 0 === d ? [] : d,
            s = i.frame,
            h = void 0 === s ? 0 : s,
            u = i.simulate,
            c = void 0 === u ? !0 : u,
            o = +new Date();
          (this.id = e),
            (this.resetFrame = function () {
              h = 0;
            }),
            (this.destroy = function () {
              delete activeThreads[e];
            }),
            (this.play = function () {
              (o = +new Date()), (activeThreads[e] = t), delete idleThreads[e];
            }),
            (this.pause = function () {
              (idleThreads[e] = t), delete activeThreads[e];
            }),
            (this.addTask = function (e) {
              -1 === n.indexOf(e) && n.push(e.bind(t));
            }),
            (this.removeTask = function (e) {
              var t = n.indexOf(e);
              t > -1 && n.splice(t, 1);
            }),
            (this.run = function () {
              var e = +new Date();
              c &&
                e > o &&
                (n.forEach(function (e) {
                  e();
                }),
                (o += 1e3 / r),
                (h += 1),
                c && t.run()),
                c || t.run();
            }),
            Object.defineProperty(this, "frame", {
              get: function () {
                return h;
              },
              set: function (e) {
                return h;
              },
            });
        }
        Object.defineProperty(exports, "__esModule", { value: !0 });
        var activeThreads = {},
          idleThreads = {},
          threadRunner = {
            addThread: addThread,
            __activeThreads: activeThreads,
            __idleThreads: idleThreads,
          },
          uuid = 0;
        tick(), (exports["default"] = threadRunner);
      },
      {},
    ],
    7: [
      function (require, module, exports) {
        "use strict";
        function initialiseCursorTracking() {
          body.addEventListener("mousemove", mouseSpeed, !1),
            body.addEventListener("touchmove", mouseSpeed, !1),
            body.addEventListener("touchstart", mouseSpeed, !1),
            body.addEventListener("touchend", mouseSpeed, !1),
            checkCursorSpeed();
        }
        function getY(e) {
          var t = void 0;
          return (t = e.touches ? e.touches[0].pageY : e.clientY);
        }
        function getX(e) {
          var t = void 0;
          return (t = e.touches ? e.touches[0].pageX : e.clientX);
        }
        function resetCursorSpeed(e) {
          for (; cursorSpeeds.length; ) cursorSpeeds.pop();
          clientY = prevClientY = getY(e);
        }
        function cursorSpeed() {
          return _math.average.apply(void 0, cursorSpeeds);
        }
        function checkCursorSpeed() {
          addMousePositionToStack(), requestAnimationFrame(checkCursorSpeed);
        }
        function addMousePositionToStack() {
          "number" == typeof clientY &&
            ("number" == typeof prevClientY || (prevClientY = clientY),
            cursorSpeeds.push(clientY - prevClientY),
            cursorSpeeds.length > 5 && cursorSpeeds.unshift(),
            (prevClientY = clientY));
        }
        function mouseSpeed(e) {
          (clientY = getY(e)), (clientX = getX(e));
        }
        Object.defineProperty(exports, "__esModule", { value: !0 }),
          (exports["default"] = initialiseCursorTracking),
          (exports.getY = getY),
          (exports.getX = getX),
          (exports.resetCursorSpeed = resetCursorSpeed),
          (exports.cursorSpeed = cursorSpeed);
        var _math = require("../method/math2.js"),
          cursorSpeeds = [],
          _document = document,
          body = _document.body,
          prevClientY = void 0,
          clientY = void 0,
          clientX = void 0;
      },
      { "../method/math2.js": 3 },
    ],
  },
  {},
  [2]
);
