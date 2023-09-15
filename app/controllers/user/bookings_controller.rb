class User::BookingsController < User::BaseController
  include BookingHelper
  before_action :logged_in_user
  before_action :load_football_pitch, only: [:new, :create]
  before_action :current_user_booking_pitches, only: :index

  def index
    search_booked_pitch
    @pagy, @booking_football_pitches = pagy @booking_football_pitches,
                                            items: Settings.pitches.per_page
  end

  def new
    @booking = Booking.new
    @booking.assign_attributes(
      user_name: current_user.name,
      phone: current_user.phone,
      football_pitch_n: @football_pitch.name,
      price: @football_pitch.price
    )
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

  def current_user_booking_pitches
    @booking_football_pitches = current_user.bookings
    return if @booking_football_pitches

    flash[:error] = t "football_pitches.find_pitch_failed"
    redirect_to root_path
  end

  def search_booked_pitch
    booked_pitch = params[:football_pitch_name]
    return if booked_pitch.blank?

    @booking_football_pitches = current_user
                                .bookings
                                .search_by_booked_pitch_name booked_pitch
  end
end
