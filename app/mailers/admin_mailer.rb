class AdminMailer < ApplicationMailer
  def monthly_revenue_report total_revenue
    @total_revenue = total_revenue

    admin_emails = User.admin.pluck(:email)

    mail to: admin_emails, subject: t("system.monthly_revenue.subject")
  end
end
