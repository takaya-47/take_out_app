class StaticPagesController < ApplicationController
  def home
    @users = User.all.order(created_at: 'DESC').limit(10)
  end

  def contact
  end
end
