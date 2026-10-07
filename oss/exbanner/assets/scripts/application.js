(function () {
  var gallery = document.getElementById("gallery");
  var search = document.getElementById("font-search");
  var count = document.getElementById("font-count");
  var fonts = window.EXBANNER_FONTS || [];

  function atom(name) {
    return /^[a-z_][a-z0-9_]*$/.test(name) ? ":" + name : ':"' + name + '"';
  }

  function card(font) {
    var article = document.createElement("article");
    article.className = "font-card";
    article.dataset.name = font.name;

    var header = document.createElement("header");
    var name = document.createElement("code");
    name.textContent = "font: " + atom(font.name);
    header.append(name);

    var art = document.createElement("pre");
    art.textContent = font.art;

    article.append(header, art);
    return article;
  }

  function filter() {
    var query = (search.value || "").trim().toLowerCase().replace(/[\s-]+/g, "_");
    var visible = 0;

    document.querySelectorAll(".font-card").forEach(function (item) {
      var match = item.dataset.name.indexOf(query) !== -1;
      item.hidden = !match;
      if (match) visible += 1;
    });

    count.textContent = visible + " of " + fonts.length + " fonts";
  }

  if (gallery) {
    fonts.forEach(function (font) {
      gallery.appendChild(card(font));
    });
    search.addEventListener("input", filter);
    filter();
  }

  document.querySelectorAll("[data-copy]").forEach(function (button) {
    button.addEventListener("click", function () {
      navigator.clipboard.writeText(button.dataset.copy).then(function () {
        button.textContent = "Copied";
        setTimeout(function () {
          button.textContent = "Copy";
        }, 1500);
      });
    });
  });
})();
