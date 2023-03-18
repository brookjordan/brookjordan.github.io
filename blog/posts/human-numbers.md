# Human numbers .js

I was playing around making a function that would output numbers as a human would say them.

## Usage

The use looks like this:
```js
buildTextNumber(0)
// => "zero"
```

### Loads of examples

```js
buildTextNumber(13)
// => "thirteen"
```

In order to accept really big numbers, you can pass in strings (don’t worry if you left some leading zeros)…
```js
buildTextNumber('0000907000021')
// => "nine hundred and seven million and twenty one"
```

Or if you’re feeling brave, even big ints…
```js
buildTextNumber(32000000000000900001n)
// => "thirty two quintillion, nine hundred thousand and one"
```
### A vigin-what-now?

The biggest accepted number so far…
```js
buildTextNumber(999999999999999999999999999999999999999999999999999999999999999999n)
// => "nine hundred and ninety nine vigintillion, nine hundred and ninety nine novemdecillion, nine hundred and ninety nine octodecillion, nine hundred and ninety nine septendecillion, nine hundred and ninety nine sexdecillion, nine hundred and ninety nine quindecillion, nine hundred and ninety nine quattuordecillion, nine hundred and ninety nine tredecillion, nine hundred and ninety nine duodecillion, nine hundred and ninety nine undecillion, nine hundred and ninety nine decillion, nine hundred and ninety nine nonillion, nine hundred and ninety nine octillion, nine hundred and ninety nine septillion, nine hundred and ninety nine sextillion, nine hundred and ninety nine quintillion, nine hundred and ninety nine quadrillion, nine hundred and ninety nine trillion, nine hundred and ninety nine billion, nine hundred and ninety nine million, nine hundred and ninety nine thousand, nine hundred and ninety nine"
```

## Playground

Try it!

<input id="NUMBER_INPUT" value="0" placeholder="1234">
<span id="NUMBER_DISPLAY">zero</span>

<script>
"use strict";
const units = [
    'zero', 'one', 'two', 'three', 'four', 'five',
    'six', 'seven', 'eight', 'nine', 'ten', 'eleven',
    'twelve', 'thirteen', 'fourteen', 'fifteen',
    'sixteen', 'seventeen', 'eighteen', 'nineteen',
];
const tens = [
    '', 'ten', 'twenty', 'thirty', 'fourty',
    'fifty', 'sixty', 'seventy', 'eighty', 'ninety',
];
const exponents = [
    '', 'thousand', 'million', 'billion', 'trillion', 'quadrillion',
    'quintillion', 'sextillion', 'septillion', 'octillion', 'nonillion',
    'decillion', 'undecillion', 'duodecillion', 'tredecillion',
    'quattuordecillion', 'quindecillion', 'sexdecillion',
    'septendecillion', 'octodecillion', 'novemdecillion', 'vigintillion',
];
const largestNumber = 1000n ** BigInt(exponents.length) - 1n;
function renderNumberGroup(numberGroup, exponent, exponentCount, ending) {
    const unit = numberGroup.at(-1);
    const ten = numberGroup.at(-2) || 0;
    const hundred = numberGroup.at(-3) || 0;
    const unitAndTen = ten * 10 + unit;
    return `${hundred ? `${units[hundred]} hundred${unitAndTen ? ' and ' : ''}` : ''}${unitAndTen && unitAndTen < 20
        ? units[unitAndTen]
        : `${ten ? `${tens[ten]} ` : ''}${unit ? units[unit] : ten || exponentCount > 1 ? '' : units[0]}`}${exponent && (hundred || unitAndTen)
        ? ` ${exponents[exponent]}${ending === 'and' ? ' and' : ending === 'comma' ? ',' : ''}`
        : ''}`;
}
function buildTextNumber(number) {
    const numbers = [...String(number)];
    const firstNonNumber = numbers.find((digit) => Number.isNaN(+digit));
    if (firstNonNumber) {
        throw new Error(`This only works with integers, but you included “${firstNonNumber}”`);
    }
    if (BigInt(number) > largestNumber) {
        throw new Error(`As of now, this only supports numbers up to 10^${exponents.length * 3}-1`);
    }
    const numberGroups = [];
    numbers.reverse();
    numbers.forEach((number) => {
        const lastGroup = numberGroups.at(-1);
        if (!lastGroup || lastGroup.length === 3) {
            numberGroups.push([+number]);
        }
        else {
            lastGroup.push(+number);
        }
    });
    numberGroups.forEach((group) => group.reverse());
    let ending = 'comma';
    const namedNumberParts = numberGroups.map((numberGroup, index, numberGroups) => {
        const rendered = renderNumberGroup(numberGroup, index, numberGroups.length, ending);
        // So as to read better, we replace the comma of the last
        //   exponent with “and” if there’s no hundred.
        // eg. “one million and three” vs “one million, three”
        if (ending === 'comma' ) {
          if (index === 0) {
            if (numberGroup.reduce((curr, item) => curr + item) === 0) {
              ending = 'none';
            } else if (numberGroup.at(-3) === 0) {
              ending = 'and';
            }
          }
        }
        else if (ending && rendered) {
            ending = 'comma';
        }
        return rendered;
    });
    namedNumberParts.reverse();
    return namedNumberParts.join(' ').replace(/\s{2,}/g, ' ');
}

const oninput = () => {
  if (!NUMBER_INPUT.value) {
    NUMBER_DISPLAY.textContent = 'Type something in!'
    return;
  }

  try {
    NUMBER_DISPLAY.textContent = buildTextNumber(NUMBER_INPUT.value);
  } catch (e) {
    NUMBER_DISPLAY.textContent = e.message;
  }
};
NUMBER_INPUT.oninput = oninput;
oninput();
</script>

## The code

For anyone wanting to try it for themseleves, or if you wanna improve on it:

```typescript
type ExponentJoiner = 'none' | 'comma' | 'and';

type NumberGroup =
  | [number]
  | [number, number]
  | [number, number, number];

const units = [
  'zero', 'one', 'two', 'three', 'four', 'five',
  'six', 'seven', 'eight', 'nine', 'ten', 'eleven',
  'twelve', 'thirteen', 'fourteen', 'fifteen',
  'sixteen', 'seventeen', 'eighteen', 'nineteen',
] as const;

const tens = [
  '', 'ten', 'twenty', 'thirty', 'fourty',
  'fifty', 'sixty', 'seventy', 'eighty', 'ninety',
] as const;

const exponents = [
  '', 'thousand', 'million', 'billion', 'trillion', 'quadrillion',
  'quintillion', 'sextillion', 'septillion', 'octillion', 'nonillion',
  'decillion', 'undecillion', 'duodecillion', 'tredecillion',
  'quattuordecillion', 'quindecillion', 'sexdecillion',
  'septendecillion', 'octodecillion', 'novemdecillion', 'vigintillion',
] as const;

const largestNumber = 1000n ** BigInt(exponents.length) - 1n;

function renderNumberGroup(
  numberGroup: NumberGroup,
  exponent: number,
  exponentCount: number,
  ending: ExponentJoiner,
) {
  const unit = numberGroup.at(-1) || 0;
  const ten = numberGroup.at(-2) || 0;
  const hundred = numberGroup.at(-3) || 0;
  const unitAndTen = ten * 10 + unit;

  return `${
    hundred ? `${units[hundred]} hundred${unitAndTen ? ' and ' : ''}` : ''
  }${
    unitAndTen && unitAndTen < 20
      ? units[unitAndTen]
      : `${ten ? `${tens[ten]} ` : ''}${
          unit ? units[unit] : ten || exponentCount > 1 ? '' : units[0]
        }`
  }${
    exponent && (hundred || unitAndTen)
      ? ` ${ending === 'and' ? ' and' : ending === 'comma' ? ',' : ''}`
      : ''
  }`;
}

function buildTextNumber(number: number | bigint | `${number}`) {
  const numbers = [...String(number).replace(/^0+/, '')];

  const firstNonNumber = numbers.find((digit) => Number.isNaN(+digit));
  if (firstNonNumber) {
    throw new Error(
      `This only works with integers, but you included ${firstNonNumber}`,
    );
  }

  if (BigInt(number) > largestNumber) {
    throw new Error(
      `As of now, this only supports numbers up to 10^${
        exponents.length * 3
      }-1`,
    );
  }

  const numberGroups: NumberGroup[] = [];

  numbers.reverse();
  numbers.forEach((number) => {
    const lastGroup = numberGroups.at(-1);
    if (!lastGroup || lastGroup.length === 3) {
      numberGroups.push([+number]);
    } else {
      lastGroup.push(+number);
    }
  });
  numberGroups.forEach((group) => group.reverse());

  let ending: ExponentJoiner = 'comma';
  const namedNumberParts = numberGroups.map(
    (numberGroup, index, numberGroups) => {
      const rendered = renderNumberGroup(
        numberGroup,
        index,
        numberGroups.length,
        ending,
      );
      // So as to read better, we replace the comma of the last
      //   exponent with “and” if there’s no hundred.
      // eg. “one million and three” vs “one million, three”
      if (ending === 'comma') {
        if (index === 0) {
          if (numberGroup.reduce((curr, item) => curr + item) === 0) {
            ending = 'none';
          } else if (numberGroup.at(-3) === 0) {
            ending = 'and';
          }
        }
      } else if (ending && rendered) {
        ending = 'comma';
      }
      return rendered;
    },
  );
  namedNumberParts.reverse();

  return namedNumberParts.join(' ').replace(/\s{2,}/g, ' ');
}
```

## AI will rule us all!

lol, jokez. I showed this to a friend and they suggested that this is exacly the kind of thing that AI would have given me a result for much more quickly than I could have written it myself. So… we tried!

### Chat GPT
Chat GPT gave up before it could finish the function (I’m wondering if it’s because I’m using the free version)

### Bing

Bing gave a kind of working version, so long as the numbers are above zero, and aren’t too big. Here are some outputs:

```js
numToWords(0)
// => ""
```

```js
numToWords(19)
// => "nineteen"
```

```js
numToWords(9999)
// => "nine nine hundred ninety nine"
```

```js
numToWords(123456789)
// => "one hundred twenty three four hundred fifty six seven hundred eighty nine"
```

It’s actually **GOT** the code to do numbers up to a trillion, but it’s added some weird code to the `bigs` line. Correct that line and you get:

```js
numToWords(123456789)
// => "one hundred twenty three million four hundred fifty six thousand seven hundred eighty nine"
```

```js
function numToWords(num) {
    const ones = ['', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'];
    const teens = ['eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen','seventeen','eighteen','nineteen'];
    const tens = ['', '', 'twenty','thirty','forty','fifty','sixty','seventy','eighty','ninety'];
    const bigs = ['', '', '', '', '', '', '', '', '', '', '', ['thousand'], ['million'], ['billion'], ['trillion']];

    let words = [];

    function convertChunk(num) {
        let chunkWords = [];
        if (num >= 100) {
            chunkWords.push(ones[Math.floor(num / 100)] + " hundred");
            num %= 100;
        }
        if (num >= 11 && num <= 19) {
            chunkWords.push(teens[num - 11]);
        } else if (num == 10 || num >= 20) {
            chunkWords.push(tens[Math.floor(num / 10)]);
            num %= 10;
        }

        if (num >= 1 && num <= 9) {
            chunkWords.push(ones[num]);
        }

        return chunkWords.join(" ");
    }

    let chunks = [];
    while (num > 0) {
        chunks.push(num % 1000);
        num = Math.floor(num / 1000);
    }

    for (let i = chunks.length -1; i >=0; i--) {
        let chunk = chunks[i];

        if (chunk !=0){
            words.push(convertChunk(chunk));

            if(bigs[i].length >0){
                words.push(bigs[i]);
            }

            if(i>0 && chunks[i-1]<100){
                words.push("and");
            }

        }else{
             words.push("");
         }


     }

     return words.join(" ");
}
```
