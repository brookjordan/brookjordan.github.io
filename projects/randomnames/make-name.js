'use strict';

const DEFAULT_NORMALITY_LEVEL = 3;

const ALPHABET = 'abcdefghijklmnopqrstuvwxyz'.split('');
const GIVEN_NAME_LETTER_COMBOS = {};
const GIVEN_NAME_FIRST_LETTERS_RAW = {};

const SURNAME_LETTER_COMBOS = {};
const SURNAME_FIRST_LETTERS_RAW = {};

ALPHABET.forEach(letter1 => {
	GIVEN_NAME_FIRST_LETTERS_RAW[letter1] = 0;
	GIVEN_NAME_LETTER_COMBOS[letter1] = {};

	SURNAME_FIRST_LETTERS_RAW[letter1] = 0;
	SURNAME_LETTER_COMBOS[letter1] = {};
});

let curr = ' ';
let prev = ' ';
let prev2 = ' ';
let prev3 = ' ';
let prev4 = ' ';

givennames.split('').forEach(letter => {
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
		let l2 = '' + prev2 + prev;
		GIVEN_NAME_LETTER_COMBOS[l2] = GIVEN_NAME_LETTER_COMBOS[l2] || {};
		GIVEN_NAME_LETTER_COMBOS[l2][curr] = GIVEN_NAME_LETTER_COMBOS[l2][curr] ? GIVEN_NAME_LETTER_COMBOS[l2][curr] + 1 : 1;

		if (prev3 !== ' ') {
			let l3 = '' + prev3 + prev2 + prev;
			GIVEN_NAME_LETTER_COMBOS[l3] = GIVEN_NAME_LETTER_COMBOS[l3] || {};
			GIVEN_NAME_LETTER_COMBOS[l3][curr] = GIVEN_NAME_LETTER_COMBOS[l3][curr] ? GIVEN_NAME_LETTER_COMBOS[l3][curr] + 1 : 1;

			if (prev4 !== ' ') {
				let l4 = '' + prev4 + prev3 + prev2 + prev;
				GIVEN_NAME_LETTER_COMBOS[l4] = GIVEN_NAME_LETTER_COMBOS[l4] || {};
				GIVEN_NAME_LETTER_COMBOS[l4][curr] = GIVEN_NAME_LETTER_COMBOS[l4][curr] ? GIVEN_NAME_LETTER_COMBOS[l4][curr] + 1 : 1;
			}
		}
	}
});

surnames.split('').forEach(letter => {
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
		let l2 = '' + prev2 + prev;
		SURNAME_LETTER_COMBOS[l2] = SURNAME_LETTER_COMBOS[l2] || {};
		SURNAME_LETTER_COMBOS[l2][curr] = SURNAME_LETTER_COMBOS[l2][curr] ? SURNAME_LETTER_COMBOS[l2][curr] + 1 : 1;

		if (prev3 !== ' ') {
			let l3 = '' + prev3 + prev2 + prev;
			SURNAME_LETTER_COMBOS[l3] = SURNAME_LETTER_COMBOS[l3] || {};
			SURNAME_LETTER_COMBOS[l3][curr] = SURNAME_LETTER_COMBOS[l3][curr] ? SURNAME_LETTER_COMBOS[l3][curr] + 1 : 1;

			if (prev4 !== ' ') {
				let l4 = '' + prev4 + prev3 + prev2 + prev;
				SURNAME_LETTER_COMBOS[l4] = SURNAME_LETTER_COMBOS[l4] || {};
				SURNAME_LETTER_COMBOS[l4][curr] = SURNAME_LETTER_COMBOS[l4][curr] ? SURNAME_LETTER_COMBOS[l4][curr] + 1 : 1;
			}
		}
	}
});

let GIVEN_NAME_FIRST_LETTERS = normalizeLetters(GIVEN_NAME_FIRST_LETTERS_RAW);
let SURNAME_FIRST_LETTERS = normalizeLetters(SURNAME_FIRST_LETTERS_RAW);

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
	let name = randomFirstLetter(firstLetters).toUpperCase();
	let i = 0;

	do {
		name += randomNextLetter(name.slice(-Math.min(name.length, 4)).toLowerCase(), letterCombos);
	} while (name.length < 3 || Math.random() * 18 > name.length);

	return name;
}

function randomFirstLetter(firstLetters) {
	let firstLetterChance = Math.random();
	let firstLetterFinder = 0;
	let i = 0;
	do {
		firstLetterFinder += firstLetters[ALPHABET[i]];
		i += 1;
	} while (firstLetterChance > firstLetterFinder);

	return ALPHABET[i - 1];
}

function randomNextLetter(prevLetters, letterCombos) {
	let nextLetter = letterCombos[prevLetters];
	while (!letterCombos[prevLetters]) {
		prevLetters = prevLetters.slice(1);
		nextLetter = letterCombos[prevLetters];
	}
	let nextLetterNormalised = normalizeLetters(nextLetter);
	let nextLettersChance = Math.random();
	let nextLetterFinder = 0;
	let i = 0;
	let alphabet = Object.keys(nextLetter).sort();
	do {
		nextLetterFinder += nextLetterNormalised[alphabet[i]];
		i += 1;
	} while (nextLettersChance > nextLetterFinder);

	return alphabet[i - 1];
}

function normalizeLetters(letters, normality = DEFAULT_NORMALITY_LEVEL) {
	let weightedLetterCounts = Object.entries(letters)
		.map(([letter, count]) => [letter, Math.round(count ** normality)])

	let totalLetterCount = weightedLetterCounts
		.reduce((acc, [_letter, count]) => acc + count, 0);
	debugger;

	return Object.fromEntries(
		weightedLetterCounts
			.map(([letter, count]) => [letter, console.log(count / totalLetterCount) || count / totalLetterCount])
	);
}
