class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
  def check_login
    redirect_to root_path 'message_type': 'alert-warning',
                          'message_text': 'You need to be logged in to access this feature' unless current_user
  end
end
