class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #make methods available in our views:
  helper_method :current_user, :logged_in?
  
  #define methods:
  def current_user
    @current_user ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end
  
  def logged_in?
    #double exclamation points make something return only true or false
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform this action"
      #sometimes :back doesn't work, so we need to account for that
      begin
        redirect_to :back
      rescue
        redirect_to root_path
      end
    end
  end
end
