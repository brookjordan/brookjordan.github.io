const themes = ["light", "dark"];

const themeMetaTags = themes.map((theme) => ({
  theme,
  element: document.querySelector(`#theme-color-meta-${theme}`),
}));

const inputs = [...themes, "auto"].map((theme) => ({
  theme,
  element: document.querySelector(`#theme--${theme}`),
}));

const THEME_STORAGE_NAME = "CURRENT_THEME";

const updateTheme = (newTheme) => {
  if (newTheme === "auto") {
    localStorage.removeItem(THEME_STORAGE_NAME);
    themeMetaTags.forEach(({ element }) => document.head.append(element));
  } else {
    localStorage.setItem(THEME_STORAGE_NAME, newTheme);
    themeMetaTags.forEach(({ element }) => element.remove());
    document.head.appendChild(
      themeMetaTags.find(({ theme }) => theme === newTheme).element
    );
  }
  inputs.forEach(({element}) => element.removeAttribute("checked"));
  inputs.find(({theme}) => theme === newTheme).element.setAttribute("checked", "checked");
};

updateTheme(localStorage.getItem(THEME_STORAGE_NAME) || "auto");
themeMetaTags.forEach(({ element }) => element.removeAttribute("media"));

inputs.forEach(({ theme, element }) => {
  element.addEventListener("change", () => {
    updateTheme(theme);
  });
});
