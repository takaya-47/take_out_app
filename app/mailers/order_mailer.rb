class OrderMailer < ApplicationMailer

  def send_when_order(orderOrderDetail)
    @orderOrderDetail = orderOrderDetail

    visit_day_id = @orderOrderDetail.visit_day_id # 1とかが代入される
    @visit_day = VisitDay.find(visit_day_id).name # アクティブハッシュのモデルからidで探し、そのidに該当するnameキーの値を取得
    visit_time_id = @orderOrderDetail.visit_time_id
    @visit_time = VisitTime.find(visit_time_id).name

    menu_id = @orderOrderDetail.menu_id # インスタンスに入っているparamsを使ってmenu_idを特定
    @menu = Menu.find(menu_id) # 特定したmenu_idを使って注文があったメニューを特定
    @user = @menu.user # 注文があったメニューを投稿したお店を特定

    mail(to: @user.email, subject: '注文のお知らせ')
  end

end
