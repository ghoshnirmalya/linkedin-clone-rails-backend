class UserMailer < ApplicationMailer
  def welcome_email(user_id)
    @user = User.find(user_id)

    mail(:to => @user.email,
         :subject => "Getting started with " + ENV.fetch("APP_NAME")) do |format|
      format.text
      format.html
    end
  end
end
