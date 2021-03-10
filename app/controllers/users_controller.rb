class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @menus = @user.menus
  end

  def index
    @users = User.all.order(created_at: 'DESC')
  end
end
