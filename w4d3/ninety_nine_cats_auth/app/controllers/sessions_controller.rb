class SessionsController < ApplicationController

  before_action :logged_in, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(session_params[:username], session_params[:password])
    if user
      login
      flash[:success] = 'You are logged in!'
      redirect_to cats_url
    else
      flash.now[:warning] = "Invalid credentials"
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
