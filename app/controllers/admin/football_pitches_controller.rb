class Admin::FootballPitchesController < Admin::BaseController
  def index
    @football_pitches = FootballPitch.newest
  end
end
