class ApplicationController < ActionController::Base

  before_action :authenticate_user!

  private

  def authenticate_user!
    token = cookies.signed[:jwt]
    render json: { error: 'Unauthorized' }, status: :unauthorized unless token_valid?(token)
  end

  def token_valid?(token)
    return false if token.blank?
    decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base)
    User.exists?(decoded_token.first['user_id'])
  rescue JWT::DecodeError
    false
  end
end
