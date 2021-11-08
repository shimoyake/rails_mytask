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
    @user = User.find_by(id: current_user.id)
    @room = Room.new(room_params)
    #binding.pry
    if @room.save
      redirect_to '/rooms'
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
	     #itemのtitleを曖昧検索
        @rooms = Room.where('rooms.room_name LIKE(?)', "%#{params[:search]}%").order(created_at: :desc)
        #フォームに入力した内容を取ってくる
        @search_result = "#{params[:search]}"
	end

  private
    def room_params
      params.permit(:room_name, :introduction, :room_price, :search).merge(id: current_user.id)
    end
end
