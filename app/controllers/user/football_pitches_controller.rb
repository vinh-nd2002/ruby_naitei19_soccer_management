# class FootballPitchesController < ApplicationController
class User::FootballPitchesController < User::BaseController
  def index
    search_football_pitches
    @pagy, @football_pitch_items = pagy @football_pitch_items,
                                        items: Settings.pitches.per_page
  end
end
