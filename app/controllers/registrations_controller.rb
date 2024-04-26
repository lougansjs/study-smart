class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, only: [:logout]

  def login
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      render json: { user: user, token: user.generate_jwt } # Gera um token JWT e retorna para o front-end
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def create
    byebug
    user = User.new
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def logout
    current_user.update(authentication_token: nil) # Limpa o token de autenticação
    head :no_content
  end

  private

  def user_params
    params.require(:registration).permit(:email, :password, :password_confirmation)
  end
end