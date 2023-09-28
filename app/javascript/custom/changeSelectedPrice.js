document.addEventListener("turbo:load", function () {
  const priceSelect = document.getElementById("price_select");
  const minPriceInput = document.getElementById("min_price_input");
  const maxPriceInput = document.getElementById("max_price_input");

  // Define the price ranges
  const priceRanges = {
    "Tất cả": { min: null, max: null },
    "Dưới 200.000đ": { min: "0", max: "200000" },
    "200.000đ - 500.000đ": { min: "200000", max: "500000" },
    "500.000đ - 1 triệu": { min: "500000", max: "1000000" },
    "Trên 1 triệu": { min: "1000000", max: null },
  };

  priceSelect?.addEventListener("change", function (e) {
    const selectedPriceRange = priceRanges[e.target.value] || {
      min: null,
      max: null,
    };
    minPriceInput.value = selectedPriceRange.min;
    maxPriceInput.value = selectedPriceRange.max;

    const form = document.getElementById("football_pitch_search");
    form.requestSubmit();
  });
});
