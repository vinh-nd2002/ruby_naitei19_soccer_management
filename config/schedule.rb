env :PATH, ENV['PATH']

set :environment, :development

every 1.months, at: "beginning_of_month", roles: [:app] do
  rake "reports:send_monthly_email"
end
