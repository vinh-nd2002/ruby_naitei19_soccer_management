class Admin::FootballPitchesController < Admin::BaseController
  # callback
  before_action :find_football_pitch_base_id, only: %i(edit update destroy show)

  def index
    @football_pitches = FootballPitch.newest
  end

  def new
    @football_pitch = FootballPitch.new
  end

  def show
    return if @football_pitch

    redirect_to admin_football_pitches_path
  end

  def create
    @football_pitch = FootballPitch.new football_pitch_params
    if @football_pitch.save
      flash[:success] = t "football_pitches.create.success"
      redirect_to admin_football_pitches_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @football_pitch.update football_pitch_params
      flash[:success] = t "football_pitches.update.success"
      redirect_to admin_football_pitch_path @football_pitch
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @football_pitch.destroy
      flash[:success] = t("football_pitches.delete.success").capitalize
    else
      flash[:danger] = t("football_pitches.delete.failed").capitalize
    end
    redirect_to admin_football_pitches_path, status: :see_other
  end

  private

  def football_pitch_params
    params.require(:football_pitch).permit(:name, :location, :length, :width,
                                           :capacity, :price, :description,
                                           :football_pitch_types, images: [])
  end

  def find_football_pitch_base_id
    @football_pitch = FootballPitch.find_by id: params[:id]

    return if @football_pitch

    flash[:warning] = t "football_pitches.find_pitch_failed"
    render :edit, status: :unprocessable_entity
  end
end
