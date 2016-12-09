class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_credentials(session_params[:username], session_params[:password])
    if @user
      log_in(@user)
      redirect_to subs_url
    else
      render :new
    end
  end

  def destroy
    @user = User.find_by(session_token: session[:session_token])
    log_out if @user
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
