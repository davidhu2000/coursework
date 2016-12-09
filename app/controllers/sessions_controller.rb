class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_credentials(session_params[:username], session_params[:password])
    if @user
      log_in(@user)
      render :index
    else
      render :new
    end
  end

  def destroy
    @user = User.find_by(session_token: session[:session_token])
    log_out if @user
    render :index
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
