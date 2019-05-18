export default function initHeaderClickFunctionality() {
  (Array.from(document.querySelectorAll('h1,h2,h3,h4,h5,h6'))
    .forEach(heading => {
      heading.onclick = e => {
        history.replaceState(null,null,new URL(`#${heading.id}`, location.href));
        heading.scrollIntoView({
          behavior: 'smooth',
          block: 'start',
        });
      };
      heading.style.cursor = 'pointer';
    })
  );
}
