class User::AccountActivationsController < User::BaseController
  def edit
    user = User.find_by(email: params[:email])
    check_activation user
  end

  def check_activation user
    if user && !user.is_activated? && user.authenticated?(:activation,
                                                          params[:id])
      user.activate
      log_in user
      flash[:success] = t "activation.success"
    else
      flash[:danger] = t "activation.invalid_link"
    end
    redirect_to root_path
  end
end
