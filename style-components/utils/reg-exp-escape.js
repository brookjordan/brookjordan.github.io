/*
 * List taken from here:
 *  https://github.com/benjamingr/RegExp.escape/blob/master/EscapedChars.md
 */

const ESCAPE_AT_BEGINNING = [
  // '0-9', // This seems to break for now
  'a-f',
  'A-F',
];

const ALWAYS_ESCAPE  = [
  '-', // must be first
  '[',
  '\\]',
  '{',
  '}',
  '(',
  ')',
  '*',
  '+',
  '?',
  '.',
  '\\\\', // required to denote a single '\'
  '^',
  '$',
  '|',
  '#',
];

const toEscape = new RegExp(`((^[${ESCAPE_AT_BEGINNING.join('')}])|([${ALWAYS_ESCAPE.join('')}]))`, 'g');

function escapeStringAsRegExpLiteral(str) {
  return str.replace(toEscape, '\\$1')
}

export default escapeStringAsRegExpLiteral;
