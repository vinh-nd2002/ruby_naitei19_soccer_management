document.addEventListener("turbo:load", function () {
  let button = document.getElementById("dropdownAccount");
  let dropdown = document.getElementById("dropdown");

  button?.addEventListener("click", function () {
    if (dropdown.classList.contains("hidden")) {
      dropdown.classList.remove("hidden");
    } else {
      dropdown.classList.add("hidden");
    }
  });
});
