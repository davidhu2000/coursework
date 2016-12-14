class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :is_moderator?

  def require_current_user
    redirect_to new_session_url unless current_user
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def log_in(user)
    session[:session_token] = user.session_token
  end

  def is_moderator?
    sub = Sub.find_by_id(params[:id])
    current_user.id == sub.mod_id
  end

  def is_author?
    post = Post.find_by_id(params[:id])
    current_user.id == post.author_id
  end

  def log_out
    current_user.reset_session_token
    current_user.save
  end
end
