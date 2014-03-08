class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_create_params)

    if @user.save
      redirect_to root_path
    else
      render :new, status: :conflict
    end
  end

  private

  def user_create_params
    if params[:user].present?
      params.require(:user).permit(:login, :email, :password, :password_confirmation)
    end
  end
end
