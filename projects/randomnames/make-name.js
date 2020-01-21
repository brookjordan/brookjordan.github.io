'use strict';

var ALPHABET = 'abcdefghijklmnopqrstuvwxyz'.split('');
var GIVEN_NAME_LETTER_COMBOS = {};
var GIVEN_NAME_FIRST_LETTERS_RAW = {};

var SURNAME_LETTER_COMBOS = {};
var SURNAME_FIRST_LETTERS_RAW = {};

ALPHABET.forEach(function (letter1) {
	GIVEN_NAME_FIRST_LETTERS_RAW[letter1] = 0;
	GIVEN_NAME_LETTER_COMBOS[letter1] = {};

	SURNAME_FIRST_LETTERS_RAW[letter1] = 0;
	SURNAME_LETTER_COMBOS[letter1] = {};
});

var curr = ' ';
var prev = ' ';
var prev2 = ' ';
var prev3 = ' ';
var prev4 = ' ';

givennames.split('').forEach(function (letter) {
	prev4 = prev3;
	prev3 = prev2;
	prev2 = prev;
	prev = curr;
	curr = letter;

	if (prev === ' ') {
		GIVEN_NAME_FIRST_LETTERS_RAW[letter] += 1;
		return;
	}

	if (curr === ' ') {
		return;
	}

	GIVEN_NAME_LETTER_COMBOS[prev][curr] = GIVEN_NAME_LETTER_COMBOS[prev][curr] ? GIVEN_NAME_LETTER_COMBOS[prev][curr] + 1 : 1;

	if (prev2 !== ' ') {
		var l2 = '' + prev2 + prev;
		GIVEN_NAME_LETTER_COMBOS[l2] = GIVEN_NAME_LETTER_COMBOS[l2] || {};
		GIVEN_NAME_LETTER_COMBOS[l2][curr] = GIVEN_NAME_LETTER_COMBOS[l2][curr] ? GIVEN_NAME_LETTER_COMBOS[l2][curr] + 1 : 1;

		if (prev3 !== ' ') {
			var l3 = '' + prev3 + prev2 + prev;
			GIVEN_NAME_LETTER_COMBOS[l3] = GIVEN_NAME_LETTER_COMBOS[l3] || {};
			GIVEN_NAME_LETTER_COMBOS[l3][curr] = GIVEN_NAME_LETTER_COMBOS[l3][curr] ? GIVEN_NAME_LETTER_COMBOS[l3][curr] + 1 : 1;

			if (prev4 !== ' ') {
				var l4 = '' + prev4 + prev3 + prev2 + prev;
				GIVEN_NAME_LETTER_COMBOS[l4] = GIVEN_NAME_LETTER_COMBOS[l4] || {};
				GIVEN_NAME_LETTER_COMBOS[l4][curr] = GIVEN_NAME_LETTER_COMBOS[l4][curr] ? GIVEN_NAME_LETTER_COMBOS[l4][curr] + 1 : 1;
			}
		}
	}
});

surnames.split('').forEach(function (letter) {
	prev4 = prev3;
	prev3 = prev2;
	prev2 = prev;
	prev = curr;
	curr = letter;

	if (prev === ' ') {
		SURNAME_FIRST_LETTERS_RAW[letter] += 1;
		return;
	}

	if (curr === ' ') {
		return;
	}

	SURNAME_LETTER_COMBOS[prev][curr] = SURNAME_LETTER_COMBOS[prev][curr] ? SURNAME_LETTER_COMBOS[prev][curr] + 1 : 1;

	if (prev2 !== ' ') {
		var l2 = '' + prev2 + prev;
		SURNAME_LETTER_COMBOS[l2] = SURNAME_LETTER_COMBOS[l2] || {};
		SURNAME_LETTER_COMBOS[l2][curr] = SURNAME_LETTER_COMBOS[l2][curr] ? SURNAME_LETTER_COMBOS[l2][curr] + 1 : 1;

		if (prev3 !== ' ') {
			var l3 = '' + prev3 + prev2 + prev;
			SURNAME_LETTER_COMBOS[l3] = SURNAME_LETTER_COMBOS[l3] || {};
			SURNAME_LETTER_COMBOS[l3][curr] = SURNAME_LETTER_COMBOS[l3][curr] ? SURNAME_LETTER_COMBOS[l3][curr] + 1 : 1;

			if (prev4 !== ' ') {
				var l4 = '' + prev4 + prev3 + prev2 + prev;
				SURNAME_LETTER_COMBOS[l4] = SURNAME_LETTER_COMBOS[l4] || {};
				SURNAME_LETTER_COMBOS[l4][curr] = SURNAME_LETTER_COMBOS[l4][curr] ? SURNAME_LETTER_COMBOS[l4][curr] + 1 : 1;
			}
		}
	}
});

var GIVEN_NAME_FIRST_LETTERS = normalizeLetters(GIVEN_NAME_FIRST_LETTERS_RAW);
var SURNAME_FIRST_LETTERS = normalizeLetters(SURNAME_FIRST_LETTERS_RAW);

function randomFullName() {
	return randomFullGivenName() + ' ' + randomFullSurname();
}

function randomFullGivenName() {
	return randomGivenName() + (Math.random() > 0.5 ? Math.random() > 0.25 ? ' ' + randomGivenName() : ' ' + randomSurname() : '');
}

function randomFullSurname() {
	return Math.random() > 0.1 ? randomSurname() : randomSurname() + '-' + randomSurname();
}

function randomGivenName() {
	return randomName(GIVEN_NAME_FIRST_LETTERS, GIVEN_NAME_LETTER_COMBOS);
}

function randomSurname() {
	return randomName(SURNAME_FIRST_LETTERS, SURNAME_LETTER_COMBOS);
}

function randomName(firstLetters, letterCombos) {
	var name = randomFirstLetter(firstLetters).toUpperCase();
	var i = 0;

	do {
		name += randomNextLetter(name.slice(-Math.min(name.length, 4)).toLowerCase(), letterCombos);
	} while (name.length < 3 || Math.random() * 18 > name.length);

	return name;
}

function randomFirstLetter(firstLetters) {
	var firstLetterChance = Math.random();
	var firstLetterFinder = 0;
	var i = 0;
	do {
		firstLetterFinder += firstLetters[ALPHABET[i]];
		i += 1;
	} while (firstLetterChance > firstLetterFinder);

	return ALPHABET[i - 1];
}

function randomNextLetter(prevLetters, letterCombos) {
	var nextLetter = letterCombos[prevLetters];
	while (!letterCombos[prevLetters]) {
		prevLetters = prevLetters.slice(1);
		nextLetter = letterCombos[prevLetters];
	}
	var nextLetterNormalised = normalizeLetters(nextLetter);
	var nextLettersChance = Math.random();
	var nextLetterFinder = 0;
	var i = 0;
	var alphabet = Object.keys(nextLetter).sort();
	do {
		nextLetterFinder += nextLetterNormalised[alphabet[i]];
		i += 1;
	} while (nextLettersChance > nextLetterFinder);

	return alphabet[i - 1];
}

function normalizeLetters(letters) {
	var totalLetterCount = Object.keys(letters).map(function (letter) {
		return letters[letter];
	}).reduce(function (acc, val) {
		return acc + val;
	}, 0);
	return Object.keys(letters).reduce(function (acc, val) {
		acc[val] = letters[val] / totalLetterCount;
		return acc;
	}, {});
}
