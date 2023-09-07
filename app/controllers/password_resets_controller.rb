class PasswordResetsController < ApplicationController
  layout "layouts/application_user"
  before_action :get_user, :check_expiration, :valid_user, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "password_reset.send_mail"
      redirect_to root_url
    else
      flash.now[:danger] = t "password_reset.not_found"
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, t("password_reset.cant_empty"))
      render :edit, status: :unprocessable_entity
    elsif @user.update(user_params)
      reset_session
      log_in @user
      @user.update_column :reset_digest, nil
      flash[:success] = t "password_reset.success"
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  # Confirms a valid user.
  def valid_user
    return if @user.is_activated? && @user.authenticated?(:reset, params[:id])

    flash[:danger] = t "password_reset.in_actived"
    redirect_to root_url
  end

  # Checks expiration of reset token.
  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "password_reset.expiration"
    redirect_to new_password_reset_url
  end
end
