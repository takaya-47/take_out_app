class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:shop_name, :category_id, :prefecture_id, :address, :business_hours, :holiday, :phone_number])
    end

end
