export function average(...numbers) {
  return numbers.length < 1
    ? 0
    : numbers.length < 2
    ? numbers[0]
    : numbers.reduce((e, r) => (e + r) / 2);
}
