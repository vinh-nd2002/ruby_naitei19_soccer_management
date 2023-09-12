class User::StaticPagesController < User::BaseController
  before_action :find_football_pitch_by_id, only: %i(show)
  def index
    @football_pitches = FootballPitch.all
    @pagy, @football_pitch_items = pagy @football_pitches,
                                        items: Settings.pitches.per_page
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
