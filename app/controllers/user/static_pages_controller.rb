class User::StaticPagesController < User::BaseController
  before_action :find_football_pitch_by_id, only: %i(show)
  def index
    search_football_pitches
    @pagy, @football_pitch_items = pagy(@football_pitch_items,
                                        items: Settings.pitches.per_page,
                                        link_extra: "data-remote='true'",
                                        page_param: :pagy)
    return if current_user.blank?

    @favorite_pitches = current_user.football_pitches
    @pagy_favorite, @favorite_pitches = pagy(@favorite_pitches,
                                             items: Settings.pitches.per_page,
                                             link_extra: "data-remote='true'",
                                             page_param: :pagy_favorite)
  end

  def show; end

  private

  def find_football_pitch_by_id
    @football_pitch = FootballPitch.find_by id: params[:id]
    return if @football_pitch

    flash[:warning] = t "static_pages.find_football_pitch.failed"
    redirect_to :root
  end
end
