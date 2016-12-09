class SessionsController < ApplicationController
  def index
    redirect_to user_url(current_user) if current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: session_params[:email])
    if @user && @user.is_password?(session_params[:password])
      login(@user)
      flash[:success] = ['Welcome to the MusicApp']
      redirect_to bands_url
    else
      flash.now[:danger] = ['Invalid Credentials, try again']
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
