module V1
  class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request

    def sign_in
      command = AuthenticateExistingUser.call(params[:data][:attributes][:email], params[:data][:attributes][:password])

      if command.success?
        render json: {auth_token: command.result}
      else
        render json: {error: command.errors}, status: :unauthorized
      end
    end

    def sign_up
      command = AuthenticateNewUser.call(params[:data][:attributes][:email], params[:data][:attributes][:password])

      if command.success?
        mail = UserMailer.welcome_email(JSON.parse(command.to_json)["user"]["id"])
        mail.deliver_now

        render json: {auth_token: command.result}
      else
        render json: {error: command.errors}, status: :unauthorized
      end
    end

    def forgot_password
      @user = User.find_by email: params[:data][:attributes][:email]

      Rails.logger.info "######"
      Rails.logger.info @user
      Rails.logger.info "######"

      new_password = Array.new(10).map { (65 + rand(58)).chr }.join
      @user.password = new_password

      if @user.save
        mail = UserMailer.forgot_password_email(@user.id, new_password)
        mail.deliver_now
      end
    end
  end
end
