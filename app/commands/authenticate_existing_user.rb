class AuthenticateExistingUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    if authenticate_existing_user
      JsonWebToken.encode(user_id: user.id)
    end
  end

  private

  attr_accessor :email, :password

  def authenticate_existing_user
    user = User.find_by_email(email)

    if user && user.authenticate(password)
      user
    else
      errors.add :user_authentication, "invalid credentials"
      nil
    end
  end
end
