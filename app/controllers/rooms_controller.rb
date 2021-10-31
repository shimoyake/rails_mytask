class RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
    @rooms = Room.all 
  end
  
  def new
    @room = Room.new
    @user = current_user.id
  end

  def create
    @user = current_user.id
    @room = Room.new(room_params)
      if @room.save
        flash[:notice]="登録しました"
        redirect_to :rooms
      else
        render "new"
        flash[:notice]="失敗しました"
      end
  end

  def edit
    @room = Room.find(params[:id])
  end

  private
    def room_params
      params.require(:room).permit(:room_name, :introduction, :room_price)
    end
end

#binding.pry