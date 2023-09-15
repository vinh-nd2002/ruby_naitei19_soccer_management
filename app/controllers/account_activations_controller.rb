class AccountActivationsController < ApplicationController
  before_action :load_user, only: :edit

  def edit
    if !@user.is_activated? && @user.authenticated?(:activation, params[:id])
      @user.activate
      log_in @user
      flash[:success] = t("activation.success")
    else
      flash[:danger] = t("activation.invalid_link")
    end
    redirect_to root_url
  end

  private

  def load_user
    @user = User.find_by(email: params[:email])
    return if @user

    flash[:danger] = t("activation.invalid_link")
    redirect_to root_url
  end
end
