class RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
    @rooms = Room.all 
  end
  
  def new
    @user = User.find_by(id: current_user.id)
    #@room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save(validate: false)
      flash[:notice] = "お部屋を登録しました"
      redirect_to rooms_path(current_user)
    else
      render "new"
    end
  end

  def edit
    @room = Room.find(params[:id])
  end
  
  def show
    @room = Room.find(params[:id]) 
  end
  
  def search
	   #itemのtitleを曖昧検索
    if @rooms = Room.where('rooms.room_name LIKE(?)', "%#{params[:search]}%").order(created_at: :desc)
    #フォームに入力した内容を取ってくる
    @search_result = "#{params[:search]}"
    
    elsif @rooms = Room.where('rooms.room_area LIKE(?)', "%#{params[:search_area]}%").order(created_at: :desc)
    #フォームに入力した内容を取ってくる
    @search_result = "#{params[:sea_area]}"
    #else @rooms.count == 0
    end
  end

  private
    def room_params
      params.permit(:room_name, :introduction, :room_price, :room_area, :address, :room_image, :search, :search_area).merge(user_id: current_user.id)
    end
end
