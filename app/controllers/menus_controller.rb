class MenusController < ApplicationController
  before_action :find_menu, only: [:show, :edit, :update]

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

  private

  def menu_params
    params.require(:menu).permit(:name, :price, :explain, :image).merge(user_id: current_user.id)
  end

  def find_menu
    @menu = Menu.find(params[:id])
  end
end
