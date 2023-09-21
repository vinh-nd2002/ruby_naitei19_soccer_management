document.addEventListener("turbo:load", function () {
  var createFormIcons = document.querySelectorAll(".fa-comment");

  createFormIcons.forEach(function (icon) {
    icon.addEventListener("click", function () {
      var bookingId = icon.id.split("-")[3];
      var reviewForm = document.getElementById(
        "review-form-container-" + bookingId
      );

      if (reviewForm) {
        reviewForm.style.display =
          reviewForm.style.display !== "block" ? "block" : "none";
      }
    });
  });
});
