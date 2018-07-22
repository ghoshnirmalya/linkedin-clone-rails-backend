# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Configure sendgrid
ActionMailer::Base.smtp_settings = {
  :user_name => ENV.fetch("SENDGRID_USERNAME"),
  :password => ENV.fetch("SENDGRID_PASSWORD"),
  :domain => ENV.fetch("SENDGRID_DOMAIN"),
  :address => ENV.fetch("SENDGRID_ADDRESS"),
  :port => ENV.fetch("SENDGRID_PORT"),
  :authentication => :plain,
  :enable_starttls_auto => true,
}
