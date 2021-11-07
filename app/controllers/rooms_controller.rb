class RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
    @rooms = Room.all 
  end
  
  def new
    @user_id = current_user.id
    @room = Room.new
  end

  def create
    @user_id = current_user.id
    @room = Room.new(params.require(:room).permit(:room_name, :introduction, :room_price))
    
    if @room.save
      redirect_to :rooms
      flash[:notice]="登録しました"
    else
      render "new"
      flash[:notice]="失敗しました"
    end
  end

  def edit
    @room = Room.find(params[:id])
  end
  
  def show
    @room = Room.find(params[:id]) 
  end
  
  def search
    if params[:room_area].present?
      @rooms = Room.where("%#{params[:room_area]}%")
    else
      @rooms = Room.none
    end
    
    #@rooms = Room.search(params[:room_area])
    #@keyword = params[:room_area]
    #render "rooms"
  end

  private
    def room_params
      params.permit(:room_name, :introduction, :room_price).merge(user_id: current_user.id)
    end
end
