let manipSelect = document.querySelector("#manip_select");
Object.keys(colourManupulators).forEach((manipName, i) => {
  let manipOption = document.createElement("option");
  if (i === 0) {
    manipOption.selected = true;
  }
  manipOption.value = manipName;
  manipOption.innerText = manipName;
  manipSelect.append(manipOption);
});

let colorSelect = document.querySelector("#color_select");
Object.keys(namedColours).forEach((colorName, i) => {
  let colorOption = document.createElement("option");
  if (i === 0) {
    colorOption.selected = true;
  }
  colorOption.value = colorName;
  colorOption.innerText = colorName;
  colorSelect.append(colorOption);
});

updateBackgroundColor();
manipSelect.onchange = colorSelect.onchange = updateBackgroundColor;

function updateBackgroundColor() {
  document.documentElement.style.backgroundColor = HSLAString(cleanHSLA(
    colourManupulators[manipSelect.value](namedColours[colorSelect.value].hsl)
  ));
}
