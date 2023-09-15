class Admin::BookingsController < Admin::BaseController
  before_action :load_booking, only: %i(update)

  def index
    search_bookings
    @pagy, @bookings = pagy @bookings,
                            items: Settings.bookings.per_page
  end

  def update
    booking_status = booking_params[:booking_status]
    if @booking.update_column(:booking_status, booking_status)
      @booking.user.send_approve_booking_email if @booking.is_approve?
      @booking.user.send_reject_booking_email if @booking.is_reject?
      flash[:success] = t "bookings.success"
    else
      flash[:danger] = t "bookings.error"
    end
    redirect_to admin_bookings_path
  end

  private
  def load_booking
    @booking = Booking.find_by id: params[:id]
    return if @booking

    flash[:danger] = t "bookings.not_found"
    redirect_to admin_bookings_path
  end

  def search_bookings
    start_at = format_date params[:start_at]
    created_at = format_date params[:created_at]
    booking_status = params[:booking_status]

    @bookings = Booking.search_by_booking_status(booking_status)
                       .search_by_start_at(start_at)
                       .search_by_created_at(created_at)
                       .newest
  end

  def format_date string
    Date.parse(string) if string.present?
  end

  def booking_params
    params.require(:booking).permit(:booking_status)
  end
end
