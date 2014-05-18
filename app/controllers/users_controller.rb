class UsersController < ApplicationController
  before_filter :skip_if_logged, only: [:new, :create, :login_form, :login]
  before_filter :check_authentication, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.includes(:team_members, :teams).find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])

    redirect_to root_path if @user != @current_user
  end

  def update
    @user = User.find(params[:id])

    redirect_to root_path if @user != @current_user

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    @user.attributes = user_create_params

    if @user.save
      flash[:notice] = 'Duomenys išsaugoti!'
      redirect_to root_path
    else
      flash[:error] = @user.errors.messages
      render :edit, status: :conflict
    end
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
    @user.authenticate!(params[:login][:password])
    session[:user_id] = @user.id
    redirect_to root_path
  rescue ActiveRecord::RecordNotFound, User::WrongPasswordError
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
