class Admin::BookingsController < Admin::BaseController
  before_action :load_booking, only: %i(update)

  def index
    @bookings = Booking.newest
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

  def booking_params
    params.require(:booking).permit(:date, :booking_status, :football_pitch_id)
  end
end
