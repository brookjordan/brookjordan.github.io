const prose = ["fluffy", "formal"];

const PROSE_STORAGE_NAME = "CURRENT_PROSE";

const proseInputs = [...prose].map((prose) => ({
  prose,
  element: document.querySelector(`#prose--${prose}`),
}));

const updateProse = (newProse) => {
  console.log(newProse);

  const selectedInput = proseInputs.find(({ prose }) => prose === newProse);
  if (!selectedInput) return;

  localStorage.setItem(PROSE_STORAGE_NAME, newProse);
  proseInputs.forEach(({ element }) => element.removeAttribute("checked"));
  selectedInput.element.setAttribute("checked", "checked");
};

updateProse(localStorage.getItem(PROSE_STORAGE_NAME) || "formal");

proseInputs.forEach(({ prose, element }) => {
  element.addEventListener("change", () => {
    updateProse(prose);
  });
});
