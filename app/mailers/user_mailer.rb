class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation user
    @user = user
    mail to: user.email, subject: t("activation.subject")
  end
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject

  def password_reset user
    @user = user
    mail to: user.email, subject: t("password_reset.title")
  end

  def approve_booking user
    @user = user
    mail to: user.email, subject: t("bookings.approve.title")
  end

  def reject_booking user
    @user = user
    mail to: user.email, subject: t("bookings.reject.title")
  end
end
