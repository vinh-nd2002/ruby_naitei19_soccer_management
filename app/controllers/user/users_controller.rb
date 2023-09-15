class User::UsersController < User::BaseController
  before_action :logged_in_user, :find_user, :correct_user,
                only: %i(edit update update_password)
  before_action :authenticate_current_password, only: :update_password
  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "users.update.basic_info.success"
      redirect_to edit_user_path @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_password
    if @user.update change_password_params
      flash[:success] = t "users.update.change_password.success"
      redirect_to edit_user_path @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def change_password_params
    filter_params = params.require(:user).permit(:new_password,
                                                 :password_confirmation)
    {password: filter_params[:new_password],
     password_confirmation: filter_params[:password_confirmation]}
  end

  def authenticate_current_password
    return if @user.authenticate(params[:user][:current_password])

    flash[:danger] = t "users.update.change_password.failed"
    render :edit, status: :unprocessable_entity
  end

  def user_params
    params.require(:user).permit(:name, :phone)
  end

  def logged_in_user
    return if logged_in?

    store_location

    flash[:danger] = t "login.title"
    redirect_to login_url, status: :see_other
  end

  def find_user
    @user = User.find_by id: params[:id] || params[:user_id]
    return if @user

    redirect_to :root,
                flash: {warning: t("users.not_found")}
  end

  def correct_user
    return if @user == current_user

    redirect_to root_url, status: :see_other
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "users.not_found"
    redirect_to root_path
  end
end
