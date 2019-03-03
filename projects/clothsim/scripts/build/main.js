(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
'use strict';

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _methodsThreadRunnerJsx = require('../methods/threadRunner.jsx');

var _methodsThreadRunnerJsx2 = _interopRequireDefault(_methodsThreadRunnerJsx);

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

	threadRunner = (0, _methodsThreadRunnerJsx2['default'])();

	xSize = parseInt(_storesQueryParametersJsx2['default'].x, 10) || 51;
	ySize = parseInt(_storesQueryParametersJsx2['default'].y, 10) || 25;
	pinned = Math.ceil((xSize - 1) / 5);

	(0, _methodsBuildClothJsx2['default'])(xSize, ySize);
	_methodsPinSideJsx2['default'].top(pinned);

	document.body.addEventListener('mousedown', beginPointDrag, false);
	document.body.addEventListener('dblclick', pinPoint, false);

	threadRunner.addThread('sim', {
		fps: _storesPhysicsJsx2['default'].fps,
		active: true
	});
	threadRunner.addTaskToThread(_methodsSimClothJsx2['default'], 'sim');

	window.onblur = function () {
		threadRunner.pauseThread('sim');
	};
	window.onfocus = function () {
		threadRunner.resumeThread('sim');
	};

	draw();
};

//	Reveal
window.glbl = function (what, value) {
	switch (what) {
		case 'fps':
			if (typeof value === 'number') {
				threadRunner.updateThread.call(null, 'sim', 'fps', value);
				_storesPhysicsJsx2['default'].fps = value;
			}

			return _storesPhysicsJsx2['default'].fps;
			break;

		case 'max speed':
			if (typeof value === 'number') {
				_storesPhysicsJsx2['default'].maxSpeed = value;
			}

			return _storesPhysicsJsx2['default'].maxSpeed;
			break;

		case 'gravity':
			if (typeof value === 'number') {
				_storesPhysicsJsx2['default'].gravity = value;
			}

			return _storesPhysicsJsx2['default'].gravity;
			break;

		case 'elasticity':
			if (typeof value === 'number') {
				_storesPhysicsJsx2['default'].elasticity = value;
			}

			return _storesPhysicsJsx2['default'].elasticity;
			break;

		case 'friction':
			if (typeof value === 'number') {
				_storesPhysicsJsx2['default'].friction = value;
			}

			return _storesPhysicsJsx2['default'].friction;
			break;

		case 'color':
			if (typeof value === 'string') {
				_storesDrawingJsx2['default'].edgeColor = value;
			}

			return _storesDrawingJsx2['default'].edgeColor;
			break;

		case 'restart':
			(0, _methodsBuildClothJsx2['default'])(xSize, ySize);
			_methodsPinSideJsx2['default'].top(pinned);
			break;
	}
};

//	Recurring draw function
function draw() {
	(0, _methodsDrawClothJsx2['default'])();

	requestAnimationFrame(draw);
}

function pinPoint(e) {
	var point = _methodsPointsJsx2['default'].getNearest(e.clientX, e.clientY);

	point.pinned = !point.pinned;
}

function beginPointDrag(e) {
	if (e.target.tagName !== 'CANVAS') {
		return;
	}
	e.preventDefault();

	var point = _methodsPointsJsx2['default'].getNearest(e.clientX, e.clientY);

	np = {
		point: point,
		pX: point.posX,
		pY: point.posY,
		cX: e.clientX * _storesDrawingJsx2['default'].pixelRatio,
		cY: e.clientY * _storesDrawingJsx2['default'].pixelRatio,
		pinned: point.pinned
	};

	point.pinned = true;

	document.body.addEventListener('mousemove', dragPoint, false);
	document.body.addEventListener('mouseup', endPointDrag, false);
	document.body.addEventListener('mouseleave', endPointDrag, false);

	dragPoint(e);
}

function endPointDrag(e) {
	document.body.removeEventListener('mousemove', dragPoint, false);
	document.body.removeEventListener('mouseup', endPointDrag, false);
	document.body.removeEventListener('mouseleave', endPointDrag, false);

	np.point.pinned = np.pinned;
	np = undefined;
}

function dragPoint(e) {
	var coX = e.clientX * _storesDrawingJsx2['default'].pixelRatio - np.cX;
	var coY = e.clientY * _storesDrawingJsx2['default'].pixelRatio - np.cY;

	np.point.posX = (e.clientX * _storesDrawingJsx2['default'].pixelRatio - _storesDrawingJsx2['default'].offset) / _storesDrawingJsx2['default'].size;
	np.point.posY = (e.clientY * _storesDrawingJsx2['default'].pixelRatio - _storesDrawingJsx2['default'].offset) / _storesDrawingJsx2['default'].size;
}

},{"../methods/buildCloth.jsx":4,"../methods/drawCloth.jsx":5,"../methods/pinSide.jsx":10,"../methods/points.jsx":11,"../methods/simCloth.jsx":12,"../methods/threadRunner.jsx":14,"../stores/drawing.jsx":16,"../stores/physics.jsx":17,"../stores/queryParameters.jsx":18}],2:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _storesClothJsx = require('../stores/cloth.jsx');

var _storesClothJsx2 = _interopRequireDefault(_storesClothJsx);

var newEdge;

exports['default'] = addEdge;

function addEdge(pointA, pointB) {

	//if ( Math.random() > 0.01 ) {
	newEdge = {
		a: pointA,
		b: pointB,
		l: Math.sqrt((pointA.posX - pointB.posX) * (pointA.posX - pointB.posX) + (pointA.posY - pointB.posY) * (pointA.posY - pointB.posY)) };

	//	length
	_storesClothJsx2['default'].edges.push(newEdge);

	return newEdge;
	//}
}
module.exports = exports['default'];

},{"../stores/cloth.jsx":15}],3:[function(require,module,exports){
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
var newPoint;

function addPoint(x, y) {

	newPoint = {
		pinned: false,

		speedX: 0,
		speedY: 0,
		posX: x,
		posY: y
	};

	_storesClothJsx2['default'].points.push(newPoint);

	return newPoint;
}

module.exports = exports['default'];

},{"../methods/points.jsx":11,"../stores/cloth.jsx":15}],4:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});
exports['default'] = buildCloth;

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _methodsAddPointJsx = require('../methods/addPoint.jsx');

var _methodsAddPointJsx2 = _interopRequireDefault(_methodsAddPointJsx);

var _methodsAddEdgeJsx = require('../methods/addEdge.jsx');

var _methodsAddEdgeJsx2 = _interopRequireDefault(_methodsAddEdgeJsx);

var _methodsPointsJsx = require('../methods/points.jsx');

var _methodsPointsJsx2 = _interopRequireDefault(_methodsPointsJsx);

var _storesClothJsx = require('../stores/cloth.jsx');

var _storesClothJsx2 = _interopRequireDefault(_storesClothJsx);

var x;
var y;
var adjoiningPoint;
var newPoint;

function buildCloth(w, h) {

	_storesClothJsx2['default'].w = w;
	_storesClothJsx2['default'].h = h;

	_storesClothJsx2['default'].points = [];
	_storesClothJsx2['default'].arrangedPoints = [];
	_storesClothJsx2['default'].edges = [];

	for (y = 0; y < h; ++y) {
		_storesClothJsx2['default'].arrangedPoints[y] = [];

		for (x = 0; x < w; ++x) {

			newPoint = (0, _methodsAddPointJsx2['default'])(x, y);
			_storesClothJsx2['default'].arrangedPoints[y][x] = newPoint;

			//	Horizontal and vertical
			adjoiningPoint = _methodsPointsJsx2['default'].get(x - 1, y);
			if (!!adjoiningPoint) {
				(0, _methodsAddEdgeJsx2['default'])(newPoint, adjoiningPoint);
			}

			adjoiningPoint = _methodsPointsJsx2['default'].get(x, y - 1);
			if (!!adjoiningPoint) {
				(0, _methodsAddEdgeJsx2['default'])(newPoint, adjoiningPoint);
			}

			//	Triangles
			//adjoiningPoint = points.get( x-1, y-1 );
			//if ( !!adjoiningPoint ) {
			//	addEdge( newPoint, adjoiningPoint );
			//}
			//
			//adjoiningPoint = points.get( x+1, y-1 );
			//if ( !!adjoiningPoint ) {
			//	addEdge( newPoint, adjoiningPoint );
			//}
		}
	}
}

module.exports = exports['default'];

},{"../methods/addEdge.jsx":2,"../methods/addPoint.jsx":3,"../methods/points.jsx":11,"../stores/cloth.jsx":15}],5:[function(require,module,exports){
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

var _methodsEdgesJsx = require('../methods/edges.jsx');

var _methodsEdgesJsx2 = _interopRequireDefault(_methodsEdgesJsx);

var _methodsDrawEdgeJsx = require('../methods/drawEdge.jsx');

var _methodsDrawEdgeJsx2 = _interopRequireDefault(_methodsDrawEdgeJsx);

var _methodsDrawPointJsx = require('../methods/drawPoint.jsx');

var _methodsDrawPointJsx2 = _interopRequireDefault(_methodsDrawPointJsx);

var _storesDrawingJsx = require('../stores/drawing.jsx');

var _storesDrawingJsx2 = _interopRequireDefault(_storesDrawingJsx);

var x;
var y;
var canvas = document.createElement('canvas');
var ctx = canvas.getContext('2d');

var resizeBuffer = false;

document.body.appendChild(canvas);

sizeCanvas();
window.onresize = function () {
	if (resizeBuffer) {
		clearTimeout(resizeBuffer);
	}
	resizeBuffer = setTimeout(sizeCanvas, 300);
};

function drawCloth() {

	ctx.clearRect(0, 0, canvas.width, canvas.height);

	ctx.strokeStyle = _storesDrawingJsx2['default'].edgeColor;
	ctx.lineWidth = _storesDrawingJsx2['default'].edgeWidth;
	_methodsEdgesJsx2['default'].each(function (edge) {
		(0, _methodsDrawEdgeJsx2['default'])(ctx, edge);
	});

	ctx.strokeStyle = _storesDrawingJsx2['default'].pointColor;
	_methodsPointsJsx2['default'].each(function (point) {
		(0, _methodsDrawPointJsx2['default'])(ctx, point);
	});
}

function sizeCanvas() {
	if (resizeBuffer) {
		clearTimeout(resizeBuffer);
		resizeBuffer = false;
	}
	canvas.width = window.innerWidth * _storesDrawingJsx2['default'].pixelRatio;
	canvas.height = window.innerHeight * _storesDrawingJsx2['default'].pixelRatio;
}
module.exports = exports['default'];

},{"../methods/drawEdge.jsx":6,"../methods/drawPoint.jsx":7,"../methods/edges.jsx":8,"../methods/points.jsx":11,"../stores/cloth.jsx":15,"../stores/drawing.jsx":16}],6:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});
exports['default'] = drawEdge;

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _methodsPointsJsx = require('../methods/points.jsx');

var _methodsPointsJsx2 = _interopRequireDefault(_methodsPointsJsx);

var _storesDrawingJsx = require('../stores/drawing.jsx');

var _storesDrawingJsx2 = _interopRequireDefault(_storesDrawingJsx);

var size = _storesDrawingJsx2['default'].size;
var ofst = _storesDrawingJsx2['default'].offset;

function drawEdge(ctx, edge) {

	ctx.beginPath();

	ctx.moveTo(edge.a.posX * size + ofst, edge.a.posY * size + ofst);
	ctx.lineTo(edge.b.posX * size + ofst, edge.b.posY * size + ofst);

	ctx.stroke();
}

module.exports = exports['default'];

},{"../methods/points.jsx":11,"../stores/drawing.jsx":16}],7:[function(require,module,exports){
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
var pointSize = _storesDrawingJsx2['default'].pointSize;

function drawPoint(ctx, point) {

	if (point.pinned) {
		ctx.beginPath();

		ctx.arc(point.posX * size + _storesDrawingJsx2['default'].offset, point.posY * size + _storesDrawingJsx2['default'].offset, pointSize, 0, 2 * Math.PI);

		ctx.stroke();
	}
}

module.exports = exports['default'];

},{"../methods/points.jsx":11,"../stores/drawing.jsx":16}],8:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _storesClothJsx = require('../stores/cloth.jsx');

var _storesClothJsx2 = _interopRequireDefault(_storesClothJsx);

var edges = {
	get: get,
	each: each
};

var i;

exports['default'] = edges;

function get(edge) {

	return undefined;
}

function each(func) {

	for (i = 0; i < _storesClothJsx2['default'].edges.length; ++i) {
		func(_storesClothJsx2['default'].edges[i], i);
	}
}
module.exports = exports['default'];

},{"../stores/cloth.jsx":15}],9:[function(require,module,exports){
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

},{"../methods/points.jsx":11}],10:[function(require,module,exports){
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

},{"../methods/pinPoint.jsx":9,"../stores/cloth.jsx":15}],11:[function(require,module,exports){
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
	get: get, //	Cheating... should be elsewhere
	each: each,
	getNearest: getNearest
};

exports['default'] = points;

//	Cheating... should be elsewhere
function get(x, y) {
	if (!!_storesClothJsx2['default'].arrangedPoints[y] && !!_storesClothJsx2['default'].arrangedPoints[y][x]) {
		return _storesClothJsx2['default'].arrangedPoints[y][x];
	}

	return undefined;
}

function getNearest(fromX, fromY) {
	var closestDist = Infinity;
	var closestPoint;

	var pointDist;
	var pointX;
	var pointY;

	each(function (point, x, y) {
		pointX = point.posX * _storesDrawingJsx2['default'].size + _storesDrawingJsx2['default'].offset - fromX * _storesDrawingJsx2['default'].pixelRatio;
		pointY = point.posY * _storesDrawingJsx2['default'].size + _storesDrawingJsx2['default'].offset - fromY * _storesDrawingJsx2['default'].pixelRatio;
		pointDist = Math.sqrt(pointX * pointX + pointY * pointY);

		if (pointDist < closestDist) {
			closestDist = pointDist;
			closestPoint = point;
		}
	});

	return closestPoint;
}

function each(func) {

	var i;

	for (i = 0; i < _storesClothJsx2['default'].points.length; ++i) {

		func(_storesClothJsx2['default'].points[i]);
	}
}
module.exports = exports['default'];

},{"../stores/cloth.jsx":15,"../stores/drawing.jsx":16}],12:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});
exports['default'] = simCloth;

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _methodsPointsJsx = require('../methods/points.jsx');

var _methodsPointsJsx2 = _interopRequireDefault(_methodsPointsJsx);

var _methodsEdgesJsx = require('../methods/edges.jsx');

var _methodsEdgesJsx2 = _interopRequireDefault(_methodsEdgesJsx);

var _methodsSimPointJsx = require('../methods/simPoint.jsx');

var _methodsSimPointJsx2 = _interopRequireDefault(_methodsSimPointJsx);

var _storesClothJsx = require('../stores/cloth.jsx');

var _storesClothJsx2 = _interopRequireDefault(_storesClothJsx);

var _storesPhysicsJsx = require('../stores/physics.jsx');

var _storesPhysicsJsx2 = _interopRequireDefault(_storesPhysicsJsx);

var newPoints;
var newPoint;

function simCloth() {

	newPoints = [];

	_methodsPointsJsx2['default'].each(function (point) {
		point.tensionX = 0;
		point.tensionY = _storesPhysicsJsx2['default'].gravity;
	});

	_methodsEdgesJsx2['default'].each(function (edge) {
		addTensionToPoints(edge);
	});

	_methodsPointsJsx2['default'].each(_methodsSimPointJsx2['default']);
}

function addTensionToPoints(edge) {
	var diffX = edge.a.posX - edge.b.posX;
	var diffY = edge.a.posY - edge.b.posY;

	var tension = Math.sqrt(diffX * diffX + diffY * diffY) - edge.l;

	edge.a.tensionX -= diffX * tension;
	edge.a.tensionY -= diffY * tension;

	edge.b.tensionX += diffX * tension;
	edge.b.tensionY += diffY * tension;
}
module.exports = exports['default'];

},{"../methods/edges.jsx":8,"../methods/points.jsx":11,"../methods/simPoint.jsx":13,"../stores/cloth.jsx":15,"../stores/physics.jsx":17}],13:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});
exports['default'] = simPoint;

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _methodsPointsJsx = require('../methods/points.jsx');

var _methodsPointsJsx2 = _interopRequireDefault(_methodsPointsJsx);

var _storesPhysicsJsx = require('../stores/physics.jsx');

var _storesPhysicsJsx2 = _interopRequireDefault(_storesPhysicsJsx);

function simPoint(p) {

	if (!p.pinned) {
		p.speedX = clamp((p.speedX + clamp(p.tensionX, _storesPhysicsJsx2['default'].maxSpeed) * _storesPhysicsJsx2['default'].elasticity) * _storesPhysicsJsx2['default'].friction, _storesPhysicsJsx2['default'].maxSpeed);
		p.speedY = clamp((p.speedY + clamp(p.tensionY, _storesPhysicsJsx2['default'].maxSpeed) * _storesPhysicsJsx2['default'].elasticity) * _storesPhysicsJsx2['default'].friction, _storesPhysicsJsx2['default'].maxSpeed);

		p.posX = p.posX + p.speedX;
		p.posY = p.posY + p.speedY;
	}
}

function clamp(value, clamp) {
	return Math.min(Math.max(value, -clamp), clamp);
}
module.exports = exports['default'];

},{"../methods/points.jsx":11,"../stores/physics.jsx":17}],14:[function(require,module,exports){
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
	threadRunner.pauseThread = pauseThread;
	threadRunner.resumeThread = resumeThread;
	threadRunner.updateThread = updateThread;
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
			newThread.resuming = true;

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
  *	@method pauseThread
  *	@memberof threadRunner
  */
	function pauseThread(IDOfThreadToBeRemoved) {

		if (!threads[IDOfThreadToBeRemoved]) {

			console.warn('No thread was paused:\n' + 'A thread with the ID "' + IDOfThreadToBeRemoved + '" was not found.');
		} else {

			threads[IDOfThreadToBeRemoved].active = false;
		}

		//	Daisy chain it
		return threadRunner;
	}

	/**
  *	@method pauseThread
  *	@memberof threadRunner
  */
	function resumeThread(IDOfThreadToBeRemoved) {

		if (!threads[IDOfThreadToBeRemoved]) {

			console.warn('No thread was paused:\n' + 'A thread with the ID "' + IDOfThreadToBeRemoved + '" was not found.');
		} else {

			threads[IDOfThreadToBeRemoved].active = true;
			threads[IDOfThreadToBeRemoved].resuming = true;
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

	/**
  *	@method addTaskToThread
  *	@memberof threadRunner
  */
	function updateThread(_threadToUpdate, toUpdate, updateTo) {

		var threadToUpdate = threadRunner.__threads[_threadToUpdate];

		if (toUpdate === 'fps') {

			if (typeof updateTo === 'number') {
				threadToUpdate.fps = updateTo;
				threadToUpdate.mspf = 1000 / updateTo;
			}
		}

		//	Daisy chain it
		return threadRunner;
	}

	function tick() {

		currentTime = +new Date();

		Object.keys(threads).forEach(function (item, index, array) {

			if (threads[item].resuming) {
				threads[item].lastRan = currentTime;
				threads[item].resuming = false;
			} else if (threads[item].active) {
				runTasksOnThread(threads[item]);
			}
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

},{}],15:[function(require,module,exports){
"use strict";

Object.defineProperty(exports, "__esModule", {
	value: true
});
var cloth = {
	w: 0,
	h: 0,
	points: [],
	arrangedPoints: [],
	edges: []
};

exports["default"] = cloth;
module.exports = exports["default"];

},{}],16:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
	value: true
});

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _storesQueryParametersJsx = require('../stores/queryParameters.jsx');

var _storesQueryParametersJsx2 = _interopRequireDefault(_storesQueryParametersJsx);

var pixelRatio = window.devicePixelRatio || 1;

var drawing = {
	pixelRatio: pixelRatio,

	size: parseInt(_storesQueryParametersJsx2['default'].size, 10) * pixelRatio || 15 * pixelRatio,
	offset: 30 * pixelRatio,

	edgeWidth: 1 * pixelRatio,
	edgeColor: '#0369CF',

	pointColor: 'red',
	pointSize: 4 * pixelRatio
};

exports['default'] = drawing;
module.exports = exports['default'];

},{"../stores/queryParameters.jsx":18}],17:[function(require,module,exports){
"use strict";

Object.defineProperty(exports, "__esModule", {
	value: true
});
var physics = {
	maxSpeed: 5,
	friction: 0.97,
	fps: 120,
	gravity: 0.005,
	elasticity: 0.1
};

exports["default"] = physics;
module.exports = exports["default"];

},{}],18:[function(require,module,exports){
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
