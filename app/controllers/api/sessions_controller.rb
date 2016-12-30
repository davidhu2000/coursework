class Api::SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(params[:username], params[:password])
    if user
      login(user)
      p 'login'
      p user.session_token
      p session[:session_token]
      redirect_to root_url
    else
      render json: user.errors.full_messages
    end
  end

  def destroy
    p current_user
    if current_user
      logout
      p 'logout'
      p session[:session_token]
      render json: {}
    else
      render json: {status: 404, message: 'no current user'}
    end
  end

end
