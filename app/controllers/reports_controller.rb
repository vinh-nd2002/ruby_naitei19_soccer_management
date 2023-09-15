class ReportsController < ApplicationController
  def monthly_revenue
    start_date = Time.current.beginning_of_month
    end_date = Time.current.end_of_month
    Booking.is_approve
           .where(start_at: start_date..end_date)
           .sum(:booking_price)
  end
end
