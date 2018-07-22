class UserMailer < ApplicationMailer
  def welcome_email(user_id)
    @user = User.find(user_id)

    mail(:to => @user.email,
         :subject => "Getting started with " + ENV.fetch("APP_NAME")) do |format|
      format.text
      format.html
    end
  end

  def forgot_password_email(user_id, new_password)
    @user = User.find(user_id)
    @new_password = new_password

    mail(:to => @user.email,
         :subject => "Reset your password at " + ENV.fetch("APP_NAME")) do |format|
      format.text
      format.html
    end
  end
end
