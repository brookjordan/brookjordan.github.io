(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
'use strict';

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _methodsThreadRunnerJs = require('../methods/threadRunner.js');

var _methodsThreadRunnerJs2 = _interopRequireDefault(_methodsThreadRunnerJs);

var _methodsBuildClothJsx = require('../methods/buildCloth.jsx');

var _methodsBuildClothJsx2 = _interopRequireDefault(_methodsBuildClothJsx);

var _methodsPinSideJsx = require('../methods/pinSide.jsx');

var _methodsPinSideJsx2 = _interopRequireDefault(_methodsPinSideJsx);

var _methodsDrawClothJsx = require('../methods/drawCloth.jsx');

var _methodsDrawClothJsx2 = _interopRequireDefault(_methodsDrawClothJsx);

var _methodsPointsJsx = require('../methods/points.jsx');

var _methodsPointsJsx2 = _interopRequireDefault(_methodsPointsJsx);

var _methodsSimClothJsx = require('../methods/simCloth.jsx');

var _methodsSimClothJsx2 = _interopRequireDefault(_methodsSimClothJsx);

var _storesPhysicsJsx = require('../stores/physics.jsx');

var _storesPhysicsJsx2 = _interopRequireDefault(_storesPhysicsJsx);

var _storesDrawingJsx = require('../stores/drawing.jsx');

var _storesDrawingJsx2 = _interopRequireDefault(_storesDrawingJsx);

var _storesQueryParametersJsx = require('../stores/queryParameters.jsx');

var _storesQueryParametersJsx2 = _interopRequireDefault(_storesQueryParametersJsx);

var threadRunner;
var np; // nearest point

var xSize;
var ySize;
var pinned;

window.onload = function () {

	threadRunner = (0, _methodsThreadRunnerJs2['default'])();

	xSize = screen.width / 10 - 8;
	ySize = screen.height / 10 - 28;
	pinned = Math.ceil((xSize - 1) / 10);

	(0, _methodsBuildClothJsx2['default'])(xSize, ySize);
	_methodsPinSideJsx2['default'].top(pinned);

	document.body.addEventListener('touchstart', beginPointDrag, false);
	document.body.addEventListener('touchend', endPointDrag, false);
	//document.body.addEventListener('dblclick',  pinPoint, false);

	threadRunner.addThread('sim', {
		fps: _storesPhysicsJsx2['default'].fps,
		active: true
	});
	threadRunner.addTaskToThread(_methodsSimClothJsx2['default'], 'sim');

	draw();
};

//	Recurring draw function
function draw() {
	(0, _methodsDrawClothJsx2['default'])();

	requestAnimationFrame(draw);
}

function pinPoint(e) {
	var point = _methodsPointsJsx2['default'].getNearest(e.touches[0].clientX, e.touches[0].clientY);

	point.pinned = !point.pinned;
}

function beginPointDrag(e) {
	console.log(e);
	var point = _methodsPointsJsx2['default'].getNearest(e.touches[0].clientX, e.touches[0].clientY);

	np = {
		point: point,
		pX: point.posX,
		pY: point.posY,
		cX: e.touches[0].clientX,
		cY: e.touches[0].clientY,
		pinned: point.pinned
	};

	point.pinned = true;

	document.body.addEventListener('touchmove', dragPoint, false);
}

function endPointDrag(e) {
	document.body.removeEventListener('touchmove', dragPoint, false);

	np.point.pinned = np.pinned;
	np = undefined;
}

function dragPoint(e) {
	var coX = e.touches[0].clientX - np.cX;
	var coY = e.touches[0].clientY - np.cY;

	np.point.posX = np.pX + coX / _storesDrawingJsx2['default'].size;
	np.point.posY = np.pY + coY / _storesDrawingJsx2['default'].size;
}

},{"../methods/buildCloth.jsx":3,"../methods/drawCloth.jsx":4,"../methods/pinSide.jsx":7,"../methods/points.jsx":8,"../methods/simCloth.jsx":9,"../methods/threadRunner.js":12,"../stores/drawing.jsx":14,"../stores/physics.jsx":15,"../stores/queryParameters.jsx":16}],2:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});
exports['default'] = addPoint;

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _storesClothJsx = require('../stores/cloth.jsx');

var _storesClothJsx2 = _interopRequireDefault(_storesClothJsx);

var _methodsPointsJsx = require('../methods/points.jsx');

var _methodsPointsJsx2 = _interopRequireDefault(_methodsPointsJsx);

var sim_elt = document.querySelector('#sim');
var pointCount = 0;
var p;

function addPoint(x, y) {
	p = _methodsPointsJsx2['default'].get(x, y);

	if (!!p) {
		console.warn('Point ' + _storesClothJsx2['default'].points[y][x].id + ' at ' + x + ':' + y + ' will be overwritten.');
	} else {
		_storesClothJsx2['default'].points[y] = _storesClothJsx2['default'].points[y] || [];
		++pointCount;
		_storesClothJsx2['default'].h = _storesClothJsx2['default'].points.length;
		_storesClothJsx2['default'].w = 0;
		_storesClothJsx2['default'].points.forEach(function (row) {
			_storesClothJsx2['default'].w = Math.max(row.length, _storesClothJsx2['default'].w);
		});
	}

	_storesClothJsx2['default'].points[y][x] = {
		x: x,
		y: y,

		id: pointCount,
		pinned: false,

		speedX: 0,
		speedY: 0,
		posX: x,
		posY: y
	};
}

module.exports = exports['default'];

},{"../methods/points.jsx":8,"../stores/cloth.jsx":13}],3:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});
exports['default'] = buildCloth;

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _methodsAddPointJsx = require('../methods/addPoint.jsx');

var _methodsAddPointJsx2 = _interopRequireDefault(_methodsAddPointJsx);

var x;
var y;

function buildCloth(w, h) {

	for (y = 0; y < h; ++y) {
		for (x = 0; x < w; ++x) {

			(0, _methodsAddPointJsx2['default'])(x, y);
		}
	}
}

module.exports = exports['default'];

},{"../methods/addPoint.jsx":2}],4:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});
exports['default'] = drawCloth;

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _storesClothJsx = require('../stores/cloth.jsx');

var _storesClothJsx2 = _interopRequireDefault(_storesClothJsx);

var _methodsPointsJsx = require('../methods/points.jsx');

var _methodsPointsJsx2 = _interopRequireDefault(_methodsPointsJsx);

var _methodsDrawPointJsx = require('../methods/drawPoint.jsx');

var _methodsDrawPointJsx2 = _interopRequireDefault(_methodsDrawPointJsx);

var x;
var y;
var canvas = document.createElement('canvas');
var ctx = canvas.getContext('2d');

canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

document.body.appendChild(canvas);

//ctx.globalAlpha = 0.01;
ctx.strokeStyle = "red";
ctx.lineWidth = 1;

function drawCloth() {

	ctx.clearRect(0, 0, canvas.width, canvas.height);
	_methodsPointsJsx2['default'].each(function (point, x, y) {
		(0, _methodsDrawPointJsx2['default'])(ctx, x, y);
	});
}

module.exports = exports['default'];

},{"../methods/drawPoint.jsx":5,"../methods/points.jsx":8,"../stores/cloth.jsx":13}],5:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});
exports['default'] = drawPoint;

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _methodsPointsJsx = require('../methods/points.jsx');

var _methodsPointsJsx2 = _interopRequireDefault(_methodsPointsJsx);

var _storesDrawingJsx = require('../stores/drawing.jsx');

var _storesDrawingJsx2 = _interopRequireDefault(_storesDrawingJsx);

var size = _storesDrawingJsx2['default'].size;
var os = _storesDrawingJsx2['default'].offset; //	offset
var ov = _storesDrawingJsx2['default'].overlap; //	overlap

var v1;
var v2;
var v4;
var v3;

var area;
var areaStretch;
var areaMax = 0;

function drawPoint(ctx, x, y) {

	v1 = _methodsPointsJsx2['default'].get(x, y, 'Draw point');
	v2 = _methodsPointsJsx2['default'].get(x + 1, y, 'Draw point');
	v4 = _methodsPointsJsx2['default'].get(x, y + 1, 'Draw point');
	v3 = _methodsPointsJsx2['default'].get(x + 1, y + 1, 'Draw point');

	if (!!v1 && !!v2 && !!v4 && !!v4) {
		area = ((v1.posX - v3.posX) * (v2.posY - v4.posY) - (v1.posY - v3.posY) * (v2.posX - v4.posX)) * 0.5;
		areaStretch = Math.floor(128 - (area - 1) * 42);

		ctx.fillStyle = "rgb(" + areaStretch + "," + areaStretch + "," + areaStretch + ")";

		ctx.beginPath();

		ctx.moveTo(v1.posX * size + os, v1.posY * size + os);
		ctx.lineTo(v2.posX * size + os + ov, v2.posY * size + os);
		ctx.lineTo(v3.posX * size + os + ov, v3.posY * size + os + ov);
		ctx.lineTo(v4.posX * size + os, v4.posY * size + os + ov);

		ctx.closePath();
		ctx.fill();
		//ctx.stroke();
	}
}

module.exports = exports['default'];

},{"../methods/points.jsx":8,"../stores/drawing.jsx":14}],6:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _methodsPointsJsx = require('../methods/points.jsx');

var _methodsPointsJsx2 = _interopRequireDefault(_methodsPointsJsx);

var pinPoint = {
	add: add,
	remove: remove,
	toggle: toggle
};

var p;

exports['default'] = pinPoint;

function add(x, y) {

	_methodsPointsJsx2['default'].get(x, y, 'Add pin').pinned = true;
}

function remove(x, y) {

	_methodsPointsJsx2['default'].get(x, y, 'Remove pin').pinned = false;
}

function toggle(x, y) {

	p = _methodsPointsJsx2['default'].get(x, y, 'Toggle pin');
	p.pinned = !p.pinned;
}
module.exports = exports['default'];

},{"../methods/points.jsx":8}],7:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _storesClothJsx = require('../stores/cloth.jsx');

var _storesClothJsx2 = _interopRequireDefault(_storesClothJsx);

var _methodsPinPointJsx = require('../methods/pinPoint.jsx');

var _methodsPinPointJsx2 = _interopRequireDefault(_methodsPinPointJsx);

var pinSide = {
	top: top,
	left: left,
	bottom: bottom,
	right: right
};

var x;
var y;
var p;

exports['default'] = pinSide;

function top(_every) {
	var every = _every || 1;

	for (x = 0; x < _storesClothJsx2['default'].w; x += every) {
		_methodsPinPointJsx2['default'].add(x, 0);
	}
}

function bottom(_every) {
	var every = _every || 1;

	for (x = 0; x < _storesClothJsx2['default'].w; x += every) {
		_methodsPinPointJsx2['default'].add(x, _storesClothJsx2['default'].h - 1);
	}
}

function left(_every) {
	var every = _every || 1;

	for (y = 0; y < _storesClothJsx2['default'].h; y += every) {
		_methodsPinPointJsx2['default'].add(0, y);
	}
}

function right(_every) {
	var every = _every || 1;

	for (y = 0; y < _storesClothJsx2['default'].h; y += every) {
		(0, _methodsPinPointJsx2['default'])(_storesClothJsx2['default'].w - 1, y);
	}
}
module.exports = exports['default'];

},{"../methods/pinPoint.jsx":6,"../stores/cloth.jsx":13}],8:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _storesClothJsx = require('../stores/cloth.jsx');

var _storesClothJsx2 = _interopRequireDefault(_storesClothJsx);

var _storesDrawingJsx = require('../stores/drawing.jsx');

var _storesDrawingJsx2 = _interopRequireDefault(_storesDrawingJsx);

var points = {
	get: get,
	each: each,
	getNearest: getNearest
};

var x;
var y;

exports['default'] = points;

function get(x, y, initiatedBy) {

	if (typeof x !== 'number') {
		return x;
	}

	if (!!_storesClothJsx2['default'].points[y] && !!_storesClothJsx2['default'].points[y][x]) {
		return _storesClothJsx2['default'].points[y][x];
	}

	//console.info( 'No point exists at ' + x + ':' + y + '. ' + initiatedBy + '.' );
	return undefined;
}

function getNearest(fromX, fromY) {
	var closestDist = Infinity;
	var closestPoint;

	var pointDist;
	var pointX;
	var pointY;

	each(function (point, x, y) {
		pointX = point.posX * _storesDrawingJsx2['default'].size + _storesDrawingJsx2['default'].offset - fromX;
		pointY = point.posY * _storesDrawingJsx2['default'].size + _storesDrawingJsx2['default'].offset - fromY;
		pointDist = Math.sqrt(pointX * pointX + pointY * pointY);

		if (pointDist < closestDist) {
			closestDist = pointDist;
			closestPoint = point;
		}
	});

	return closestPoint;
}

function each(func) {

	for (y = 0; y < _storesClothJsx2['default'].h; ++y) {
		for (x = 0; x < _storesClothJsx2['default'].w; ++x) {

			func(get(x, y), x, y);
		}
	}
}
module.exports = exports['default'];

},{"../stores/cloth.jsx":13,"../stores/drawing.jsx":14}],9:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});
exports['default'] = simCloth;

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _methodsPointsJsx = require('../methods/points.jsx');

var _methodsPointsJsx2 = _interopRequireDefault(_methodsPointsJsx);

var _methodsSimPointJsx = require('../methods/simPoint.jsx');

var _methodsSimPointJsx2 = _interopRequireDefault(_methodsSimPointJsx);

var newPoints;
var newPoint;

function simCloth() {

	newPoints = [];

	_methodsPointsJsx2['default'].each(function (point, x, y) {
		newPoints[y] = newPoints[y] || [];

		if (!point.pinned) {
			newPoints[y][x] = (0, _methodsSimPointJsx2['default'])(point);
		} else {
			newPoints[y][x] = undefined;
		}
	});

	_methodsPointsJsx2['default'].each(function (point, x, y) {
		newPoint = newPoints[y][x];

		if (!!newPoints[y][x]) {
			point.posX = newPoint.posX;
			point.posY = newPoint.posY;
			point.speedX = newPoint.speedX;
			point.speedY = newPoint.speedY;
		}
	});
}

module.exports = exports['default'];

},{"../methods/points.jsx":8,"../methods/simPoint.jsx":10}],10:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});
exports['default'] = simPoint;

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _methodsPointsJsx = require('../methods/points.jsx');

var _methodsPointsJsx2 = _interopRequireDefault(_methodsPointsJsx);

var _methodsStatsJsx = require('../methods/stats.jsx');

var _methodsStatsJsx2 = _interopRequireDefault(_methodsStatsJsx);

var _storesPhysicsJsx = require('../stores/physics.jsx');

var _storesPhysicsJsx2 = _interopRequireDefault(_storesPhysicsJsx);

var p;
var newPoint;
var tension;
var maxSpeed = 2;

function simPoint(x, y) {

	newPoint = {};
	p = _methodsPointsJsx2['default'].get(x, y, 'Simulate pont');
	tension = _methodsStatsJsx2['default'].tension(p);

	newPoint.speedX = Math.min(Math.max((p.speedX + tension.x / 100) * _storesPhysicsJsx2['default'].friction, -_storesPhysicsJsx2['default'].maxSpeed), _storesPhysicsJsx2['default'].maxSpeed);
	newPoint.speedY = Math.min(Math.max((p.speedY + tension.y / 100) * _storesPhysicsJsx2['default'].friction, -_storesPhysicsJsx2['default'].maxSpeed), _storesPhysicsJsx2['default'].maxSpeed);

	newPoint.posX = p.posX + newPoint.speedX;
	newPoint.posY = p.posY + newPoint.speedY;

	return newPoint;
}

module.exports = exports['default'];

},{"../methods/points.jsx":8,"../methods/stats.jsx":11,"../stores/physics.jsx":15}],11:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _methodsPointsJsx = require('../methods/points.jsx');

var _methodsPointsJsx2 = _interopRequireDefault(_methodsPointsJsx);

var stats = {
	tension: tension
};

var basePoint;

var left;
var right;
var above;
var below;
var aboveLeft;
var aboveRight;
var belowLeft;
var belowRight;

var tension;
var tensionX;
var tensionY;
var maxTension = 0;

var diffX;
var diffY;

exports['default'] = stats;

function tension(x, y) {
	basePoint = _methodsPointsJsx2['default'].get(x, y, 'Calculate tension');
	tensionX = 0;
	tensionY = 0;

	if (!basePoint) {
		console.warn('Attempted to get the tension of non-existant point.');
		return NaN;
	}

	//	Get tensions
	addTensionFor(0, 1);
	addTensionFor(0, -1);
	addTensionFor(1, 0);
	addTensionFor(-1, 0);

	tensionY += 0.03;

	return {
		x: tensionX,
		y: tensionY
	};
}

function addTensionFor(x, y) {
	var newPoint = _methodsPointsJsx2['default'].get(basePoint.x + x, basePoint.y + y);

	if (newPoint) {
		addTension(x, y, newPoint.posX - basePoint.posX, newPoint.posY - basePoint.posY);
	}
}

function addTension(x, y, diffX, diffY) {
	tension = Math.sqrt(diffX * diffX + diffY * diffY);

	tensionX += diffX * tension - x;
	tensionY += diffY * tension - y;
}
module.exports = exports['default'];

},{"../methods/points.jsx":8}],12:[function(require,module,exports){
/**
 *	@typedef thread
 *	@type {Object}
 *
 *	@property {number}		fps			- The number of times this thread's tasks run every second
 *	@property {boolean}		active		- Whether or not this thread should currently be running its tasks
 *	@property {array}		tasks		- An array of functions, or 'tasks', this thread will run every 'tick'
 */

/**
 *	Returns a threadRunner object. This is used for running 'simulations', or 'multi-run-functions' a certain number of times per second in a way which setTimeout cannot guarantee.
 *	@function
 *	@name createThreadRunner
 *	@returns {threadRunner} threadRunner
 */
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});
function createThreadRunner() {

	/**
  *	@namespace threadRunner
  */
	var threadRunner = {};
	var threads = {};
	var currentTime = +new Date();
	var defaults = {
		newThread__fps: 60,
		newThread__active: false
	};

	threadRunner.addThread = addThread;
	threadRunner.removeThread = removeThread;
	threadRunner.addTaskToThread = addTaskToThread;

	/**
  *	@name __threads
  *	@type {Array.thread}
  *	@memberof threadRunner
  */
	threadRunner.__threads = threads;

	tick();

	return threadRunner;

	//	FUNCTIONS	//	FUNCTIONS	//

	/**
  *	@method threadRunner.addThread
  *	@memberof threadRunner
  */
	function addThread(newThreadID, _newThread) {

		var newThread = {};

		if (!newThreadID) {

			console.warn('No thread was added.\n' + 'An ID is required to add a new thread.');
		} else {

			_newThread = _newThread || {};

			//	Force tasks to be empty
			newThread.tasks = [];
			//	The FPS should be set to the one provided, if it's a number
			//		else it should default to the... default
			newThread.fps = typeof _newThread.fps === 'number' ? _newThread.fps : defaults.newThread__fps;
			//	The number of milliseconds per frame
			//		calculated to reduce calculation during simulation
			newThread.mspf = 1000 / newThread.fps;
			//	The active state should be set to the one provided, if it's a boolean
			//		else it should default to the... default
			newThread.active = typeof _newThread.active === 'boolean' ? _newThread.active : defaults.newThread__active;
			//	Created
			newThread.created = +new Date();
			//	Last ran
			newThread.lastRan = newThread.created;

			threads[newThreadID] = newThread;
		}

		//	Daisy chain it
		return threadRunner;
	}

	/**
  *	@method removeThread
  *	@memberof threadRunner
  */
	function removeThread(IDOfThreadToBeRemoved) {

		if (!threads[IDOfThreadToBeRemoved]) {

			console.warn('No thread was removed:\n' + 'A thread with the ID "' + IDOfThreadToBeRemoved + '" was not found.');
		} else {

			delete threads[IDOfThreadToBeRemoved];
		}

		//	Daisy chain it
		return threadRunner;
	}

	/**
  *	@method addTaskToThread
  *	@memberof threadRunner
  */
	function addTaskToThread(taskToAdd, _threadToAddTo) {

		var threadToAddTo;

		if (! typeof taskToAdd === 'function') {

			console.warn('No task was added:\n' + 'A task must be a fuction.');
		} else if (typeof _threadToAddTo !== 'string') {

			console.warn('No task was added:\n' + 'A thread must be requested by its ID.');
		} else {

			threadToAddTo = threadRunner.__threads[_threadToAddTo];

			if (!threadToAddTo) {

				console.warn('No task was added:\n' + 'A thread with the ID "' + _threadToAddTo + '" was not found.');
			} else {

				threadToAddTo.tasks.push(taskToAdd);
			}
		}

		//	Daisy chain it
		return threadRunner;
	}

	function tick() {

		currentTime = +new Date();

		Object.keys(threads).forEach(function (item, index, array) {

			runTasksOnThread(threads[item]);
		});

		requestAnimationFrame(tick);
	}

	function runTasksOnThread(thread) {

		while (thread.lastRan < currentTime) {

			thread.tasks.forEach(function (item, index, array) {
				item();
			});

			thread.lastRan += thread.mspf;
		}
	}
};

exports['default'] = createThreadRunner;
module.exports = exports['default'];

},{}],13:[function(require,module,exports){
"use strict";

Object.defineProperty(exports, "__esModule", {
	value: true
});
var cloth = {
	w: 0,
	h: 0,
	points: []
};

exports["default"] = cloth;
module.exports = exports["default"];

},{}],14:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _storesQueryParametersJsx = require('../stores/queryParameters.jsx');

var _storesQueryParametersJsx2 = _interopRequireDefault(_storesQueryParametersJsx);

var drawing = {
	size: parseInt(_storesQueryParametersJsx2['default'].size, 10) || 10,
	offset: 40,
	overlap: 1
};

exports['default'] = drawing;
module.exports = exports['default'];

},{"../stores/queryParameters.jsx":16}],15:[function(require,module,exports){
"use strict";

Object.defineProperty(exports, "__esModule", {
	value: true
});
var physics = {
	maxSpeed: 5,
	friction: 0.98,
	fps: 200
};

exports["default"] = physics;
module.exports = exports["default"];

},{}],16:[function(require,module,exports){
"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});
var queryParameters = (function (a) {
    if (a == "") return {};
    var b = {};
    for (var i = 0; i < a.length; ++i) {
        var p = a[i].split('=', 2);
        if (p.length == 1) b[p[0]] = "";else b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
    }
    return b;
})(window.location.search.substr(1).split('&'));

exports["default"] = queryParameters;
module.exports = exports["default"];

},{}]},{},[1]);
