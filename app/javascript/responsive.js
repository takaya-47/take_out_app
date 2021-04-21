const hamburger = () => {
  const hamburgerIcon = document.getElementById("hamburger-icon");
  const headerMenu = document.getElementById("header-menu");
  const close = document.getElementById("close");

  hamburgerIcon.addEventListener('click', () => {
    headerMenu.classList.add("show");
  });
  close.addEventListener('click', () => {
    headerMenu.classList.remove("show");
  });
}


window.addEventListener('load', hamburger);