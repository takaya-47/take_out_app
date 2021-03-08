class OrdersController < ApplicationController
  def new
    @orderOrderDetail = OrderOrderDetail.new
    @menu = Menu.find(params[:menu_id])
  end

  def create
    binding.pry
    @orderOrderDetail = OrderOrderDetail.new(order_params)
    # フォームオブジェクトクラスではvalid?メソッドを実行できないので、こちらで検証する
    if @orderOrderDetail.valid?
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
end
