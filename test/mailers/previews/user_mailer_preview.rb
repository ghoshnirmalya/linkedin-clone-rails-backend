class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.with(user: User.first).welcome_email(1)
  end

  def forgot_password_email
    @new_password = "some_new_password"
    UserMailer.with(user: User.first).forgot_password_email(1, @new_password)
  end
end
