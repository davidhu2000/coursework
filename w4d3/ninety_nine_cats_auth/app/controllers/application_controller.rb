class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def login
    user = User.find_by_username(params[:session][:username])
    session[:session_token] = SecureRandom.urlsafe_base64(128)
    user.session_token = session[:session_token]
    user.save!
  end

  def logout
    session[:session_token] = nil
    current_user.reset_session_token! if current_user
    @current_user = nil
  end

  def logged_in
    if current_user
      redirect_to cats_url
    end
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  helper_method :current_user
end
