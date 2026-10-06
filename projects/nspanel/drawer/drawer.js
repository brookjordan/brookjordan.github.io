const drawer = document.querySelector(".drawer");
const drawerTitle = document.querySelector(".drawer h3");

drawer.addEventListener("pointerdown", () => {
  drawer.classList.toggle("drawer--open");
});
