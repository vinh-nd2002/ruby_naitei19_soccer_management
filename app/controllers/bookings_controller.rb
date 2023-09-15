class BookingsController < ApplicationController
  layout "layouts/application_user"
  before_action :logged_in_user
  before_action :load_football_pitch, only: [:new, :create]

  def new
    @booking = Booking.new
    @booking.user_name = current_user.name
    @booking.phone = current_user.phone
    @booking.football_pitch_n = @football_pitch.name
    @booking.price = @football_pitch.price
  end

  def edit; end

  def create
    @booking = current_user.bookings.new(
      booking_params.merge(
        football_pitch_id: params[:football_pitch_id],
        booking_status: :pending
      )
    )
    handle_booking_result @booking
  end

  private

  def handle_booking_result booking
    if booking.overlaps_with_other_bookings?
      flash[:danger] = t("booking.duplicate")
      render :new, status: :unprocessable_entity
    elsif booking.save
      flash[:success] = t("booking.success")
      redirect_to root_path
    else
      flash[:danger] = t("booking.failed")
      render :new, status: :unprocessable_entity
    end
  end

  def booking_params
    params.require(:booking).permit(Booking::UPDATE_ATTRS)
  end

  def load_football_pitch
    @football_pitch = FootballPitch.find_by(id: params[:football_pitch_id])
    return if @football_pitch

    flash[:error] = t("football_pitch.not_found")
    redirect_to root_path
  end
end
