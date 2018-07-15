class AuthenticateNewUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    if authenticate_new_user
      JsonWebToken.encode(user_id: @user.id)
    end
  end

  private

  attr_accessor :email, :password

  def authenticate_new_user
    @user = User.new(email: email, password: password)

    if @user.save
      @user
    else
      errors.add :user_authentication, "invalid credentials"
    end
  end
end
