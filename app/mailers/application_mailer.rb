class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("SENDGRID_DOMAIN")
  layout "mailer"
end
