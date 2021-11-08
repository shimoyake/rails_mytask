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
    @rooms = Room.where('rooms.room_name LIKE(?)', "%#{params[:search]}%").order(created_at: :desc)
    #フォームに入力した内容を取ってくる
    @search_result = "#{params[:search]}"
	end

  private
    def room_params
      params.permit(:room_name, :introduction, :room_price, :search).merge(user_id: current_user.id)
    end
end
