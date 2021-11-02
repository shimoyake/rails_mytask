class ReservesController < ApplicationController
  before_action :authenticate_user!
  
  def index #予約ルーム一覧
    @rooms = Room.all
    @reserves = Reserve.all
  
  end
  
  def new #ルームの予約
    @user = current_user.id
    @rooms = Room.all
    @reserves = Reserve.new
  end
  
  def confirm #予約確認画面
    @room = Room.find(params[:room_id])
    @reserve = Reserve.new(reserve_params)
  
    @reserve.save
      render :index if @reserve.invalid?
  end
  
  def create
    @user = current_user.id
    @room = Room.find(params[:room_id])
    @reserve = Reserve.new(reserve_params)
    
    if @reserve.save
      flash[:notice]="登録しました"
      redirect_to '/reserves'
    else
      render "new"
      flash[:notice]="失敗しました"
    end
    
  end
  
  def update
    
  end
  
  
  private
    def reserve_params
      params.permit(:begin, :end, :number_of_peple, :room_id).merge(user_id: current_user.id)
    end
    
end
