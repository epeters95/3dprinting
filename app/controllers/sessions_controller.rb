class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    username = params[:user][:username]
    password = params[:user][:password]
    user = User.find_by_credentials(username, password)

    if user.nil?
      flash[:errors] = "Invalid username or password"
      redirect_to new_sessions_url
    else
      login!(user)
      redirect_to user_url(user.id)
    end
  end

  def destroy
    logout!
    redirect_to root_url
  end
end
