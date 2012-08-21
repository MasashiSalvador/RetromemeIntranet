#coding: UTF-8
class SessionsController < ApplicationController
  skip_before_filter :check_logined, :only => ['login','callback']
  def index
    @msg = 'facebook login page'
  end
  def login
    @msh = 'login with facebook'
  end
  def callback
    auth = request.env["omniauth.auth"]
    #Search in user model
    user = User.find_by_provider_and_uid(auth["provider"],auth["uid"])

    #in case where user exists
    if user
      session[:user_id] = user.id
      redirect_to root_url :notice => "Login has finished"
    else #in case not exists
      User.create_with_omniauth(auth)
      user = User.find_by_provider_and_uid(auth["provider"],auth["uid"])
      session[:user_id] = user.id
      #logger.debug("user created")
      #msg = auth["info"]["name"] + "さんの" + auth["provider"] + "アカウントと接続しました"
      #redirect_to root_url
      redirect_to :controller => "users", :action => "updateCompanyName"
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Log out"
  end
end
