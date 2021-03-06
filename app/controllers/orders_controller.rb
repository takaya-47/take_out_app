class OrdersController < ApplicationController
  before_action :move_to_root

  def new
    @orderOrderDetail = OrderOrderDetail.new
  end

  def create
    @orderOrderDetail = OrderOrderDetail.new(order_params)
    # フォームオブジェクトクラスではvalid?メソッドを実行できないので、こちらで検証する
    if @orderOrderDetail.valid?
      # Payjp側にカード情報を送信して決済を完了させる
      pay_menu
      # フォームオブジェクトクラスで定義済みのsaveメソッドを実行
      @orderOrderDetail.save
      # メニューの投稿ユーザーに注文メールを送る
      OrderMailer.send_when_order(@orderOrderDetail).deliver_now
      flash[:success] = 'ご注文ありがとうございます！'
      redirect_to root_path
    else
      find_menu
      render 'new'
    end
  end

  private

  def order_params
    params.require(:order_order_detail).permit(:quantity, :total_price, :last_name, :first_name, :last_name_kana, :first_name_kana, :prefecture_id, :address, :phone_number, :visit_day_id, :visit_time_id).merge(
      menu_id: params[:menu_id].to_i, token: params[:token]
    )
  end

  def pay_menu
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: order_params[:total_price],
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def find_menu
    @menu = Menu.find(params[:menu_id])
  end

  def move_to_root
    find_menu
    if current_user && current_user.id == @menu.user.id
      flash[:alert] = '権限がありません'
      redirect_to root_path
    end
  end
end
