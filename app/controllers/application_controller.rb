class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :check_logined
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def check_logined
    if session[:user_id] then
      begin
        @user = User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound
        reset_session
      end
    end
    
    unless @user
      logger.debug("=======================================")
      redirect_to :controller => 'sessions', :action => 'login'
    end
  end
end
