/* Kancelaria Lisowiec — script.js */
(function () {
  "use strict";

  /* --- mobilne menu --- */
  var toggle = document.querySelector(".nav-toggle");
  var nav = document.querySelector(".nav");
  if (toggle && nav) {
    toggle.addEventListener("click", function () {
      var open = nav.classList.toggle("is-open");
      toggle.setAttribute("aria-expanded", open ? "true" : "false");
    });
    nav.addEventListener("click", function (e) {
      if (e.target.tagName === "A") nav.classList.remove("is-open");
    });
  }

  /* --- filtr bazy wiedzy --- */
  var filterBar = document.querySelector(".filter-bar");
  if (filterBar) {
    var cards = Array.prototype.slice.call(document.querySelectorAll("[data-cat]"));
    filterBar.addEventListener("click", function (e) {
      var btn = e.target.closest("button");
      if (!btn) return;
      filterBar.querySelectorAll("button").forEach(function (b) {
        b.classList.toggle("is-active", b === btn);
      });
      var cat = btn.dataset.filter;
      cards.forEach(function (c) {
        var show = cat === "all" || c.dataset.cat === cat;
        c.style.display = show ? "" : "none";
      });
    });
  }

  /* --- formularze (demo, bez backendu) --- */
  document.querySelectorAll("form[data-demo]").forEach(function (form) {
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      var note = form.querySelector(".form__result");
      if (!note) {
        note = document.createElement("p");
        note.className = "form__result form__note";
        form.appendChild(note);
      }
      note.textContent =
        "Dziękujemy. To wersja demonstracyjna formularza — aby wiadomości trafiały na skrzynkę kancelarii, należy podłączyć obsługę e-mail (np. usługę formularzy lub skrypt serwerowy).";
      form.reset();
    });
  });

  /* --- rok w stopce --- */
  var y = document.querySelector("[data-year]");
  if (y) y.textContent = new Date().getFullYear();
})();
