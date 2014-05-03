class UsersController < ApplicationController
  class WrongPasswordError < StandardError; end

  before_filter :skip_if_logged, only: [:new, :create, :login_form, :login]

  def index
    @users = User.all
  end

  def show
    @user = User.includes(:team_members, :teams).find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_create_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = @user.errors.messages
      render :new, status: :conflict
    end
  end

  def login_form
    @login = Login.new
  end

  def login
    params[:login] ||= {}
    @user = User.find_by!(login: params[:login][:login])

    if @user.authenticate(params[:login][:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      raise WrongPasswordError.new('Invalid password')
    end
  rescue ActiveRecord::RecordNotFound, WrongPasswordError
    @login ||= Login.new(params[:login])
    @login.errors.add(:login, :wrong_login)
    flash[:error] = @login.errors.messages
    render :login_form, status: :conflict
  end

  def logout
    session.delete(:user_id)
    redirect_to root_path
  end

  private

  def skip_if_logged
    redirect_to root_path if @current_user
  end

  def user_create_params
    if params[:user].present?
      params.require(:user).permit(:login, :email, :password, :password_confirmation)
    end
  end
end
