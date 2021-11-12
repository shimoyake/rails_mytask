class ReservesController < ApplicationController
  before_action :authenticate_user!
  
  def index #予約ルーム一覧
    @rooms = Room.all
    @reserves = Reserve.where(user_id: current_user.id )
  end
  
  def update
    Reserve.create(reserve_params)
    @reserve = Reserve.find(params[:id])
  end
  
  def confirm #予約確認画面
    @room = Room.find(params[:room_id])
    @reserve = Reserve.new(reserve_params)
    
    if @reserve.save(validate: true)
      redirect_to '/reserves/new' if @reserve.invalid?
    else
      flash[:notice] = "必須項目を全て入力してください。チェックアウトはチェックインの日付より後に設置してください。"
      redirect_to "/rooms/#{params[:room_id]}"
    end
  end
  
  def update
    @reserve = Reserve.new(reserve_params)
  end
  
  def destroy
      @reserve = Reserve.find(params[:id])
      @reserve.destroy
      flash[:notice] = "予約情報を削除しました"
      redirect_to :reserves
  end
  
  private
    def reserve_params
      params.permit(:begin, :end, :number_of_peple, :room_id).merge(user_id: current_user.id)
    end
    
end
