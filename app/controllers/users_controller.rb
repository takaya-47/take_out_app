class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @menus = @user.menus.order(created_at: 'DESC')
  end

  def index
    @users = User.all.order(created_at: 'DESC')
  end
end
