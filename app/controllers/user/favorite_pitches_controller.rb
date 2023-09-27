class User::FavoritePitchesController < User::BaseController
  before_action :logged_in_user
  before_action :load_football_pitch, only: %i(create destroy)
  def index
    @favorite_pitches = current_user.football_pitches
  end

  def create
    if favorite_pitch_exists?
      flash[:warning] = t("football_pitch.favorite.already_favorited")
    else
      favorite_pitch = current_user.favorite_pitches
                                   .new(football_pitch: @football_pitch)
      if favorite_pitch.save
        flash[:success] = t("football_pitch.favorite.added")
      else
        flash[:danger] = t("football_pitch.favorite.failed")
      end
    end
    redirect_to root_path
  end

  def destroy
    if favorite_pitch_exists?
      if current_user.football_pitches.delete(@football_pitch)
        flash[:success] = t("football_pitch.favorite.removed")
      else
        flash[:danger] = t("football_pitch.favorite.remove_failed")
      end
    else
      flash[:danger] = t("football_pitch.favorite.remove_failed")
    end
    redirect_to favorite_pitches_path
  end

  private

  def favorite_pitch_exists?
    current_user.favorite_pitches.exists?(football_pitch: @football_pitch)
  end
end
