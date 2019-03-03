const bloxElt    = document.getElementById('blox');
const entityTest = document.createElement('h1');
const COUNT      = 512;
const VERSION    = '0.2';
const DEADCHAR   = '@';
const DEADCHARS  = {
  '0.1': '§',
  '0.2': DEADCHAR,
};
let i = COUNT;

while (i > 0) {
  buildChar(--i);
}

function buildChar(i) {
  const block  = document.createElement('div'); block.className = 'block';
  const canvas = document.createElement('canvas');
  const input  = document.createElement('input');
  const ctx    = canvas.getContext('2d');
  const array  = i.toString(2).split('').reverse();
  
  const saveElt = document.createElement('a');
  saveElt.setAttribute('download', 'download');
  saveElt.style.visibility    = 'hidden';
  saveElt.style.pointerEvents = 'none';

  let setValueAfter = false;

  fillValue(input, i);
  input.setAttribute('pattern', '.{1}');
  input.setAttribute('placeholder', '•');
  input.addEventListener('focus', e => {
    input.select();
  });
  input.addEventListener('keyup', e => {
    if (e.which === 13 /* Enter */) { 
      input.blur();
      return false;
    }

    if (setValueAfter) { clearTimeout(setValueAfter); }

    if (input.value.length > 1) {
      setValueAfter = setTimeout(() => {
        setValueAfter = false;
        setInput(input, i);
      }, 1000);
    } else {
      storeValueOfInput(input, i);
    }
  });
  input.addEventListener('blur', e => {
    if (setValueAfter) { clearTimeout(setValueAfter); }

    if (input.value.length > 1) {
      setInput(input, i);
    } else {
      storeValueOfInput(input, i);
    }
  });

  block.addEventListener('click', () => {
    input.focus();
  });

  canvas.width  = 3;
  canvas.height = 3;

  array.forEach((j, index) => {
    if (j === '1') {
      const x = index % 3;
      const y = Math.floor(index / 3);
      ctx.fillStyle = "black";
      ctx.fillRect(x, y, 1, 1);
    }
  });

  block.appendChild(input);
  block.appendChild(canvas);
  bloxElt.insertBefore(block, bloxElt.firstChild);
}

function setInput(input, i) {
  const value = input.value;

  if (/^&[^;]+;/.test(input.value)) {
    entityTest.innerHTML = input.value;
    if (entityTest.textContent.length === 1) {
      input.value = entityTest.textContent;
    }
  } else if (isNaN(parseInt(input.value))) {
    entityTest.innerHTML = `&${input.value};`;
    if (entityTest.textContent.length === 1) {
      input.value = entityTest.textContent;
    }
  } else {
    entityTest.innerHTML = `&#${input.value};`;
    if (entityTest.textContent.length === 1) {
      input.value = entityTest.textContent;
    }
  }

  storeValueOfInput(input, i);
}

function storeValueOfInput(input, i) {
  localStorage.setItem(`shapeChar_${i}`, input.value);
}

function fillValue(input, i) {
  const value = localStorage.getItem(`shapeChar_${i}`);
  if (value && value !== DEADCHARS[VERSION]) {
    input.value = value;
  }
}

//  Get data to be used with setData
function getData() {
  const data = new Array(COUNT);
  data.fill(DEADCHARS[VERSION]);

  data.forEach((item, i) => {
    data[i] = localStorage.getItem(`shapeChar_${i}`) || DEADCHARS[VERSION];
  });

  return data.join('');
}

//  Puts data into localStorage
//  Requires a page refresh to see results
function setData(dataString, version='0.1', { overrideExisting } = {}) {
  const data = dataString.split('');

  data.forEach((item, i) => {
    debugger;
    if ((overrideExisting || !localStorage.getItem(`shapeChar_${i}`)) && item !== DEADCHARS[version]) {
      localStorage.setItem(`shapeChar_${i}`, item);
    }
  });

  if (confirm('This requires a page refresh. Do this now?')) {
    location.reload();
  }
}
