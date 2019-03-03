(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _randomString = require('../method/randomString.js');

var _randomString2 = _interopRequireDefault(_randomString);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var sprytSheets = {
  init: initialiseFilePicker
};
var filePickerClassName = (0, _randomString2.default)(30);
var style = document.createElement('style');
style.innerHTML = '\n  .' + filePickerClassName + ' {\n    overflow: hidden;\n  }\n\n  .' + filePickerClassName + '__input {\n    position: absolute;\n    top: -9999px;\n    left: -9999px;\n  }\n';
style.setAttribute('id', 'picker-styles-' + filePickerClassName);
document.head.insertBefore(style, document.head.firstChild);

exports.default = sprytSheets;

function initialiseFilePicker(pickerClass) {
  var picker_elt = document.querySelector('.' + pickerClass);
  var pickerButton_elt = document.createElement('button');
  var pickerLabel_elt = document.createElement('span');

  pickerButton_elt.className = picker_elt.className + ' ' + filePickerClassName;
  pickerButton_elt.addEventListener('click', openPicker);

  picker_elt.className = filePickerClassName + '__input';

  pickerLabel_elt.className = filePickerClassName + '__label';
  pickerLabel_elt.innerText = picker_elt.getAttribute('title');

  picker_elt.parentNode.insertBefore(pickerButton_elt, picker_elt);
  pickerButton_elt.appendChild(pickerLabel_elt);
  pickerButton_elt.appendChild(picker_elt);

  return {
    elt: picker_elt,
    button: pickerButton_elt
  };

  function openPicker() {
    picker_elt.click();
  }
}

},{"../method/randomString.js":4}],2:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
var sprytSheets = {
  init: initialiseSpryteSheetDrawer
};

exports.default = sprytSheets;

function initialiseSpryteSheetDrawer(drawerClass) {
  var drawer_elt = document.querySelector('.' + drawerClass);
  var toggle_elt = document.createElement('button');

  toggle_elt.className = drawerClass + '__toggle';
  toggle_elt.addEventListener('click', toggleDrawer);

  drawer_elt.appendChild(toggle_elt);

  return {
    toggle: toggleDrawer,

    elt: drawer_elt,
    button: toggle_elt
  };

  function toggleDrawer() {
    drawer_elt.classList.toggle(drawerClass + '--open');
  }
}

},{}],3:[function(require,module,exports){
"use strict";

var _togglable = require("../component/togglable.js");

var _togglable2 = _interopRequireDefault(_togglable);

var _filePicker = require("../component/file-picker.js");

var _filePicker2 = _interopRequireDefault(_filePicker);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

_togglable2.default.init('spryt-sheets');
_togglable2.default.init('spryt-animations');

_filePicker2.default.init('spryt-map-picker');

},{"../component/file-picker.js":1,"../component/togglable.js":2}],4:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
var startLetters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
var otherLetters = '0123456789---___'.split('');
var allLetters = startLetters.concat(otherLetters);

exports.default = function (length) {
  var str = '';
  for (var i = length; i > 0; --i) {
    str += str.length ? allLetters[Math.floor(Math.random() * allLetters.length)] : startLetters[Math.floor(Math.random() * startLetters.length)];
  }
  return str;
};

},{}]},{},[3]);
