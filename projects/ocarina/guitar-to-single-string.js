const stave = String.raw`
e |------------------------------|------------------|------------------20-18-18----|---18-------------------------|------------------------------|------------------|------------------------22----|------------------------------|------------------------------------------------------|------------------|---------22-22-------18-------|------------------------------|------------------------------|------------------------------|---------------20-18----|------------------|
B |------------------------------|------------------|---------------27-------------|------20-------20-------------|------------------------------|------------------|------------------25-20-------|---25-------------------------|------------------------------------------------------|------------------|---------------27-25----------|------------------------------|------------------------------|------------------------------|------------------------|---18-------------|
G |------------------22-27-29----|---29-29-29-29----|---29----29-------------------|------------------------------|------------------22-27-29----|---29-29-29-29----|---29----29----31-------------|------------------------------|------------------------------------24-27----29-------|---31-29-31-29----|---31-------------------------|------------------------------|------------------22-27-29----|---31-31-29----31-31-29-------|---29-31-31-29----------|------------------|
D |------------------------------|------------------|------------------------------|------------------------------|------------------------------|------------------|------------------------------|------------------------------|------------------------------------------------------|------------------|------------------------38----|---38-------------------------|------------------------------|------------------------------|------------------------|------------------|
A |------------------------------|------------------|------------------------------|------------------------------|------------------------------|------------------|------------------------------|------------------------------|------------------------------------------------------|------------------|------------------------------|------------------------------|------------------------------|------------------------------|------------------------|------------------|
E |------------------------------|------------------|------------------------------|------------------------------|------------------------------|------------------|------------------------------|------------------------------|------------------------------------------------------|------------------|------------------------------|------------------------------|------------------------------|------------------------------|------------------------|------------------|
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
