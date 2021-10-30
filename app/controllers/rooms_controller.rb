class RoomsController < ApplicationController
  
  def index
    @users = User.all
    @rooms = Room.all 
  end
  
  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to rooms_path
      flash[:notice]="スケジュールを登録しました"
    else
      render :new
      flash[:notice]="失敗しました"
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  private
    def room_params
      params.require(:room).permit(:room_name)
    end
end