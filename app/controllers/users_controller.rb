class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user.id
    @users = User.all
    @rooms = Room.all 
  end
  
  def show
    @user = current_user.id
    @room = Room.new
  end
  
  def profile
    @user = User.find_by(id: current_user.id)
    #@user = User.find_by(id: params[:id])
  end
  
  def update
     @user = User.find_by(id: current_user.id)
     @user = User.update(user_params)
     #binding.pry
    if flash[:notice] = "更新しました"
       redirect_to users_profile_path
    else
      flash[:notice] = "必須項目を全て入力してください"
       render :new
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:user_name, :user_introduction, :image).merge(id: current_user.id)
    end
  
end