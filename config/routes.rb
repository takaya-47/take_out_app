Rails.application.routes.draw do
  root 'static_pages#home'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:show, :index]

  resources :menus do
    resources :orders, only: [:new, :create]
  end
end
