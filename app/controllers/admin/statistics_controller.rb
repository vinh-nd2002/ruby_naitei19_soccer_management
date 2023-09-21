class Admin::StatisticsController < Admin::BaseController
  before_action :logged_in_user

  def show; end

  def index
    @total_users = User.count
    @total_pitch = FootballPitch.count
    @most_booked_pitch = most_booked_pitch_name
    @total_price = total_price_for_current_month
    @data = revenue_by_month
    @data1 = revenue_by_capacity

    start_date_param = params[:start_date]
    return if start_date_param.blank?

    @total = calculate_total_revenue(start_date_param)
  end

  private

  def most_booked_pitch_name
    FootballPitch.joins(:bookings)
                 .group("football_pitches.id")
                 .order("COUNT(bookings.id) DESC")
                 .first.name
  end

  def total_price_for_current_month
    month_now = Time.zone.today.beginning_of_month
    month_last = Time.zone.today.end_of_month
    Booking.where("start_at >= ? AND end_at <= ?", month_now, month_last)
           .sum(:booking_price)
  end

  def revenue_by_month
    @data = Hash.new(0)
    current_date = Time.zone.today
    start_date = (current_date - 5.months).beginning_of_month
    end_date = current_date.end_of_month

    (start_date..end_date).each do |m|
      month_end = m + 1.day
      bookings = Booking.where("start_at >= ? AND end_at <= ?", m, month_end)

      next if bookings.blank?

      month_name = m.strftime("%B")
      total_revenue = bookings.sum(:booking_price)
      @data[month_name] += total_revenue
    end

    @data
  end

  def revenue_by_capacity
    @data1 = Hash.new(0)
    month_now = Time.zone.today.beginning_of_month
    month_last = Time.zone.today.end_of_month
    c = Booking.where(start_at: month_now..month_last)

    c.each do |booking|
      pitch_id = booking.football_pitch_id
      capacity = FootballPitch.find(pitch_id).capacity
      @data1[capacity] += booking.booking_price
    end

    @data1
  end

  def calculate_total_revenue start_date_param
    year, month = start_date_param.split("-").map(&:to_i)
    start_date = Date.new(year, month, 1).beginning_of_month
    end_date = Date.new(year, month, -1).end_of_month
    capacity = params[:pitch_type]
    bookings = Booking.where(start_at: start_date..end_date)
    total = 0

    bookings.each do |booking|
      pitch_id = booking.football_pitch_id
      total += booking.booking_price if
        capacity.to_i == FootballPitch.find(pitch_id).capacity
    end

    total
  end
end
