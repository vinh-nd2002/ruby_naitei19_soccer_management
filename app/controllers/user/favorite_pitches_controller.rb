class User::FavoritePitchesController < User::BaseController
  before_action :logged_in_user

  def index
    @favorite_pitches = current_user.football_pitches
  end
end
