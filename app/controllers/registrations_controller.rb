class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, except: [:logout, :login, :create]

  def login
    user = User.find_by(email: user_params["email"])
    if user&.valid_password?(params[:password])
      token = generate_token(user)
      cookies.signed[:jwt] = { value: token, httponly: true }
      render json: user
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def logout
    cookies.delete(:jwt)
    head :no_content
  end

  def create
    byebug
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def generate_token(user)
    payload = { user_id: user.id }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  private

  def user_params
    params.require(:registration).permit(:name, :email, :password, :password_confirmation)
  end
end