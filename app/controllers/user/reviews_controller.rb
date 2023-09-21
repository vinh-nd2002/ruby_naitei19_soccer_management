class User::ReviewsController < User::BaseController
  before_action :logged_in_user, only: %i(create index new)

  def index
    @reviews = current_user.reviews.newest
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build review_params
    if @review.save
      flash[:success] = t "reviews.success"
    else
      flash[:danger] = t "reviews.failed"
    end
    redirect_to bookings_path
  end

  private
  def review_params
    params.require(:review).permit(:user_id, :football_pitch_id,
                                   :rating, :comment)
  end
end
