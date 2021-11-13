class RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
    @rooms = Room.all 
  end
  
  def new
    @user = User.find_by(id: current_user.id)
  end
  
  def create
    @room = Room.new(room_params)
    if @room.save(validate: false)
      flash[:notice] = "お部屋を登録しました"
      redirect_to rooms_path(current_user)
    else
      flash[:notice] = "必須項目を全て入力してください"
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
    if params[:search_area].present?
    @rooms = Room.where('rooms.address LIKE(?)', "%#{params[:search_area]}%")
    @search_result = "#{params[:search_area]}"
    
    elsif params[:search].present?
    @rooms = Room.where('rooms.room_name LIKE(?)', "%#{params[:search]}%")
    @search_result = "#{params[:search]}"
    end
  end

  private
    def room_params
      params.permit(:room_name, :introduction, :room_price, :address, :image, :search, :search_area).merge(user_id: current_user.id)
    end
end
