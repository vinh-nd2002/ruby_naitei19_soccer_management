$("body").on("change", "#price_select", function () {
  const selectedValue = this.value;
  let minPrice, maxPrice;
  switch (selectedValue) {
    case "Tất cả":
      minPrice = null;
      maxPrice = null;
      break;
    case "Dưới 200.000đ":
      minPrice = 0;
      maxPrice = 200000;
      break;
    case "200.000đ - 500.000đ":
      minPrice = 200000;
      maxPrice = 500000;
      break;
    case "500.000đ - 1 triệu":
      minPrice = 500000;
      maxPrice = 1000000;
      break;
    case "Trên 1 triệu":
      minPrice = 1000000;
      maxPrice = null;
      break;
    default:
      break;
  }

  const minPriceInput = document.getElementById("min_price_input");
  const maxPriceInput = document.getElementById("max_price_input");
  minPriceInput.value = minPrice;
  maxPriceInput.value = maxPrice;
});
