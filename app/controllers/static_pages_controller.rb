class StaticPagesController < ApplicationController
  def index
    @football_pitches = FootballPitch.all
    @pagy, @football_pitch_items = pagy @football_pitches,
                                        items: Settings.PITCHES.PER_PAGE
  end
end
