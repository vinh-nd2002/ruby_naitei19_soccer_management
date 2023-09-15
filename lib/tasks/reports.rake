namespace :reports do
  desc "Send monthly email report to admin"
  task send_monthly_email: :environment do
    total_revenue = ReportsController.new.monthly_revenue

    AdminMailer.monthly_revenue_report(total_revenue).deliver_now
  end
end
