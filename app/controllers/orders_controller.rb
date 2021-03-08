class OrdersController < ApplicationController
  def new
    @orderOrderDetail = OrderOrderDetail.new
    @menu = Menu.find(params[:menu_id])
  end

  def create
    @orderOrderDetail = OrderOrderDetail.new(order_params)
    # フォームオブジェクトクラスではvalid?メソッドを実行できないので、こちらで検証する
    if @orderOrderDetail.valid?
      pay_menu
      @orderOrderDetail.save
      flash[:success] = "ご注文ありがとうございます!"
      redirect_to root_path
    else
      @menu = Menu.find(params[:menu_id])
      render 'new'
    end
  end

  private
  def order_params
    params.require(:order_order_detail).permit(:quantity, :total_price, :last_name, :first_name, :last_name_kana, :first_name_kana, :prefecture_id, :address, :phone_number, :visit_day_id, :visit_time_id).merge(menu_id: params[:menu_id].to_i, token: params[:token])
  end

  def pay_menu
    Payjp.api_key = "sk_test_434bc308205ab4662218b143"
    Payjp::Charge.create(
      :amount => order_params[:total_price],
      :card => order_params[:token],
      :currency => 'jpy'
    )
  end
end
