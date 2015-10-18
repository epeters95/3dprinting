class UsersController < ApplicationController
  attr_reader :password

  def new
    render :new
  end

  def show
    if signed_in?
      @user = User.find(params[:id])
      render :show
    else
      redirect_to new_sessions_url
    end
  end

  def create
    new_user = User.new
    new_user.username = params[:user][:username]
    new_user.password = params[:user][:password]
    if new_user.save
      login!(new_user)
      redirect_to user_url(new_user.id)
    else
      flash[:errors] = "Please enter a password"
      redirect_to new_users_url
    end
  end

  def index
    @users = User.all
    render :index
  end

end
