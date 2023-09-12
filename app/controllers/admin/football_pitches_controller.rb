class Admin::FootballPitchesController < Admin::BaseController
  def index
    @football_pitches = FootballPitch.newest
  end

  def new
    @football_pitch = FootballPitch.new
  end

  def create
    if FootballPitch.create! football_pitch_params
      flash[:success] = t "football_pitches.create.success"
      redirect_to admin_football_pitches_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def football_pitch_params
    params.require(:football_pitch).permit(:name, :location, :length, :width,
                                           :capacity, :price, :description,
                                           :football_pitch_types, images: [])
  end
end
