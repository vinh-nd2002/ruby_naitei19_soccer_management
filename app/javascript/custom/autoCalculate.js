function updateTotalPrice() {
  const startTimeInput = document.getElementById("booking_start_at");
  const endTimeInput = document.getElementById("booking_end_at");
  const totalPriceInput = document.getElementById("booking_booking_price");
  const pricePerHour = parseFloat(
    document.getElementById("booking_price_per_hour").value
  );
  if (startTimeInput.value && endTimeInput.value && pricePerHour) {
    const startTime = new Date(startTimeInput.value);
    const endTime = new Date(endTimeInput.value);
    const durationInMilliseconds = endTime - startTime;
    const durationInHours = Math.ceil(
      durationInMilliseconds / (1000 * 60 * 60)
    );
    totalPriceInput.value = durationInHours * pricePerHour;
  }
}

document.addEventListener("turbo:load", function () {
  var bookingForm = document.getElementById("booking-form");
  bookingForm?.addEventListener("change", updateTotalPrice);
});
