/* Shokz Auto-Fill — small progressive enhancements. No dependencies. */
(function () {
  "use strict";

  /* Reveal sections as they enter the viewport. If IntersectionObserver is
     missing, or the reader prefers reduced motion, everything is shown at once. */
  var reduce = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  var targets = document.querySelectorAll(".reveal");

  if (!("IntersectionObserver" in window) || reduce) {
    targets.forEach(function (el) {
      el.classList.add("is-in");
    });
  } else {
    var io = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add("is-in");
            io.unobserve(entry.target);
          }
        });
      },
      { rootMargin: "0px 0px -8% 0px", threshold: 0.06 }
    );
    targets.forEach(function (el) {
      io.observe(el);
    });
  }

  /* Highlight the table-of-contents entry for the section currently on screen. */
  var tocLinks = Array.prototype.slice.call(
    document.querySelectorAll(".toc a[href^='#']")
  );
  if (tocLinks.length && "IntersectionObserver" in window) {
    var sections = tocLinks
      .map(function (a) {
        var id = a.getAttribute("href").slice(1);
        var el = document.getElementById(id);
        return el ? { link: a, el: el } : null;
      })
      .filter(Boolean);

    var spy = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          var match = sections.filter(function (s) {
            return s.el === entry.target;
          })[0];
          if (!match) return;
          if (entry.isIntersecting) {
            tocLinks.forEach(function (a) {
              a.classList.remove("is-active");
            });
            match.link.classList.add("is-active");
          }
        });
      },
      { rootMargin: "-88px 0px -70% 0px", threshold: 0 }
    );
    sections.forEach(function (s) {
      spy.observe(s.el);
    });
  }

  /* Copy-to-clipboard for any element carrying data-copy. */
  document.querySelectorAll("[data-copy]").forEach(function (btn) {
    btn.addEventListener("click", function () {
      var text = btn.getAttribute("data-copy");
      var done = function () {
        var was = btn.getAttribute("data-label") || btn.textContent;
        btn.setAttribute("data-label", was);
        btn.textContent = "Copied";
        window.setTimeout(function () {
          btn.textContent = was;
        }, 1400);
      };
      if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(text).then(done, function () {});
      }
    });
  });

  /* Any element with data-year gets the current year, so the footer never
     goes stale. */
  document.querySelectorAll("[data-year]").forEach(function (el) {
    el.textContent = String(new Date().getFullYear());
  });
})();
