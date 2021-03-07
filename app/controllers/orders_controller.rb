class OrdersController < ApplicationController
  def new
    @OrderOrderDetail = OrderOrderDetail.new
  end

  def create
    binding.pry
    @OrderOrderDetail = OrderOrderDetail.new(order_params)
    if @OrderOrderDetail.save
      flash[:success] = "ご注文ありがとうございます!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
    def order_params
      params.require(:orderoderdetail).permit(:)
    end
end
