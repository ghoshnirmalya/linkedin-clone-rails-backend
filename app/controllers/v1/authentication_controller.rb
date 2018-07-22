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
  end
end
