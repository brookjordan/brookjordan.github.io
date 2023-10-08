const stave = String.raw`
e |--13-17-19------|--13-17-19------|--13-17-19-24---|--22----19------|--19-15-12-------10---|-----15------|--13-17-19------|--13-17-19------|--13-17-19-24---|--22----19------|----------------------|--15---------|-----12-13------|--15-17-19------|--20---------|-----12-13------|--15-17-19------|--20-22-24---|-----12-13------|--15-17-19------|--20---------|--------13-12---|--15-13-17-15---|--19-17-20-19---|--22----20----24-25----22---|-------|----|-----24-|
B |----------------|----------------|----------------|-----------25---|----------------------|--17----17---|----------------|----------------|----------------|-----------25---|--29-24-20-------24---|-----15-17---|--15------------|----------------|-----24------|--15------------|----------------|-------------|--15------------|----------------|-----24------|--15-13---------|----------------|----------------|----------------------------|--29---|----|--------|
G |----------------|----------------|----------------|----------------|----------------------|-------------|----------------|----------------|----------------|----------------|----------------------|-------------|----------------|----------------|--------21---|----------------|----------------|-------------|----------------|----------------|--------21---|----------------|----------------|----------------|----------------------------|-------|----|--------|
D |----------------|----------------|----------------|----------------|----------------------|-------------|----------------|----------------|----------------|----------------|----------------------|-------------|----------------|----------------|-------------|----------------|----------------|-------------|----------------|----------------|-------------|----------------|----------------|----------------|----------------------------|-------|----|--------|
A |----------------|----------------|----------------|----------------|----------------------|-------------|----------------|----------------|----------------|----------------|----------------------|-------------|----------------|----------------|-------------|----------------|----------------|-------------|----------------|----------------|-------------|----------------|----------------|----------------|----------------------------|-------|----|--------|
E |----------------|----------------|----------------|----------------|----------------------|-------------|----------------|----------------|----------------|----------------|----------------------|-------------|----------------|----------------|-------------|----------------|----------------|-------------|----------------|----------------|-------------|----------------|----------------|----------------|----------------------------|-------|----|--------|
`.trim();

const offsets = {
  e: 24,
  B: 19,
  G: 15,
  D: 10,
  A: 5,
  E: 0,
};

const symbolStringToSymbols = (symbolString, offset) => {
  let nextPosition = 0;
  let symbolPosition = 0;
  let previousSymbol = "";
  let collected = "";
  let symbolPositions = [];

  symbolString.split("").forEach((symbol, index, symbols) => {
    nextPosition += 1;

    const symbolAsNumber = +symbol;
    if (Number.isNaN(symbolAsNumber)) {
      if (collected) {
        symbolPositions.push({
          name: +collected + offset,
          position: symbolPosition,
        });
        symbolPosition += collected.length;
        collected = "";
      }

      if (
        symbol !== "-" ||
        (symbolPositions.length && previousSymbol === "-")
      ) {
        symbolPositions.push({
          name: symbol,
          position: symbolPosition,
        });
      }

      symbolPosition = nextPosition;
    } else {
      collected += symbolAsNumber;

      if (index === symbols.length - 1) {
        symbolPositions.push({
          name: +collected + offset,
          position: symbolPosition,
        });
      }
    }

    previousSymbol = symbol;
  });

  return symbolPositions;
};

const lines = stave.split("\n").map((line) => {
  const lineData = { raw: line };
  if (/^\w *\|/.test(line)) {
    lineData.rootNote = line[0];
    lineData.offset = offsets[line[0]] || 0;
    lineData.symbolsString = line.replace(/^\w *\|/, "");
  }
  lineData.symbols = symbolStringToSymbols(
    lineData.symbolsString,
    lineData.offset
  );
  return lineData;
});

const mergedPositions = [];
lines.forEach((line) => {
  line.symbols.forEach((symbol) => {
    let existingPosition = mergedPositions.find(
      (position) => position.position === symbol.position
    );
    if (!existingPosition) {
      existingPosition = {
        position: symbol.position,
        symbols: new Set(),
      };
      mergedPositions.push(existingPosition);
    }
    existingPosition.symbols.add(symbol.name);
    if (existingPosition.symbols.size > 1) {
      existingPosition.symbols.delete("-", "|");
    }
  });
});
mergedPositions.sort((a, b) => a.position - b.position);

const staveRaw = mergedPositions
  .map((position) => {
    const value = [...position.symbols.values()][0];

    return typeof value === "number" ? value : `'${value}'`;
  })
  .join(", ");

const singleLineStave = staveRaw
  // kill unknown symbols
  .replace(/, '[^|-]+?'/g, "")
  // kill gaps trailing and preceeding line breaks
  .replace(/('-', )+'\|', ('-', )+/g, "'|', ")
  // kill duplicate gaps
  .replace(/(, '-'){2,}/g, "")
  // kill trailing line ends
  .replace(/(, '[|-]')+$/, "");

const multiLineStave = singleLineStave
  // break lines on line ends
  .replaceAll("'|', ", "'|',\n");
