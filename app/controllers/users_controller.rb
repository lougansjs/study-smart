class UsersController < ActionController::Base

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  # PUT /users/:id
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    render json: @user
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end