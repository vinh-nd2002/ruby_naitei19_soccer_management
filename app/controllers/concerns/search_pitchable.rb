module SearchPitchable
  extend ActiveSupport::Concern

  def search_football_pitches
    @q = FootballPitch.ransack(params[:q])
    @q.price_gteq = params.dig(:q, :min_price)
    @q.price_lteq = params.dig(:q, :max_price)
    @football_pitch_items = @q.result(distinct: true)
  end
end
