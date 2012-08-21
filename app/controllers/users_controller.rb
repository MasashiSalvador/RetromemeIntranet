#coding: UTF-8
class UsersController < ApplicationController
  layout 'tousers'
  # GET /users
  # GET /users.json
  def updateCompanyName
    @user = current_user
  end
  def fillCompanyName
    @user = current_user
    @user.company = params[:user][:company]
    @user.save!
    msg = @user.username + "さんの" + @user.provider + "アカウントと接続しました"
    redirect_to root_url , :notice => msg
  end
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  def listing
    @users = User.all
  end
  # GET /users/1
  # GET /users/1.json

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
