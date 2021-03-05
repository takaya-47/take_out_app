class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters_sign_up, if: :devise_controller?
  before_action :configure_permitted_parameters_account_update, if: :devise_controller?

  private

  def configure_permitted_parameters_sign_up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:shop_name, :category_id, :prefecture_id, :address, :business_hours, :holiday, :phone_number, :image])
  end

  def configure_permitted_parameters_account_update
    devise_parameter_sanitizer.permit(:account_update, keys: [:shop_name, :category_id, :prefecture_id, :address, :business_hours, :holiday, :phone_number, :image])
  end

end
