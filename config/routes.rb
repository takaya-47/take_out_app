Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/contact', to: "static_pages#contact"

  devise_for :users
  resources :users, only: [:show, :index]

  resources :menus
  resources :orders, only: [:new, :create]
end
