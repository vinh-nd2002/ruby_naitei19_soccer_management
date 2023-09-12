module SearchPitchable
  extend ActiveSupport::Concern

  def search_football_pitches
    @search_params = football_pitch_search_params
    @football_pitch_items = FootballPitch
                            .search_by_name(@search_params[:name])
                            .search_by_location(@search_params[:location])
                            .search_by_capacity(@search_params[:capacity])
                            .search_by_price(@search_params[:min_price],
                                             @search_params[:max_price])
                            .newest
  end

  private
  def football_pitch_search_params
    params.permit(:name, :location, :date, :start_time, :end_time,
                  :capacity, :min_price, :max_price)
  end
end
