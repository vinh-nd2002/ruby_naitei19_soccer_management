# class FootballPitchesController < ApplicationController
class User::FootballPitchesController < User::BaseController
  def index
    @search_params = football_pitch_search_params
    @football_pitch_items = FootballPitch
                            .search_by_name(@search_params[:name])
                            .search_by_location(@search_params[:location])
                            .search_by_capacity(@search_params[:capacity])
                            .search_by_price(@search_params[:min_price],
                                             @search_params[:max_price])
                            .newest

    @pagy, @football_pitch_items = pagy @football_pitch_items,
                                        items: Settings.pitches.per_page

    render "user/static_pages/home"
  end

  private
  def football_pitch_search_params
    params.permit(:name, :location, :date, :start_time, :end_time,
                  :capacity, :min_price, :max_price)
          .to_h.compact
  end
end
