class Api::SessionsController < ApplicationController
  def create
    p session_params
    user = User.find_by_credentials(session_params[:username], session_params[:password])
    p user
    if user
      login(user)
      redirect_to root_url
    else
      render json: {text: 'Invalid Credentials'}.to_json, status: 404
    end
  end

  def destroy
    if current_user
      logout
      render json: {}
    else
      render json: { text: 'No current user' }.to_json, status: 404
    end
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end

end
