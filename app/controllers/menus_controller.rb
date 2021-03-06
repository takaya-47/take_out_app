class MenusController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :find_menu, only: [:show, :edit, :update, :destroy]
  before_action :move_to_root, only: [:edit, :update, :destroy]

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)
    if @menu.save
      flash[:success] = 'メニューを投稿しました！'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @menu.update(menu_params)
      flash[:success] = 'メニューを変更しました！'
      redirect_to menu_path(@menu)
    else
      render 'edit'
    end
  end

  def destroy
    @menu.destroy
    flash[:success] = 'メニューを削除しました！'
    redirect_to user_path(@menu.user)
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :price, :explain, :image).merge(user_id: current_user.id)
  end

  def find_menu
    @menu = Menu.find(params[:id])
  end

  def move_to_root
    if current_user.id != @menu.user.id
      flash[:alert] = '権限がありません'
      redirect_to root_path
    end
  end
end
