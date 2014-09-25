Rails.application.routes.draw do
  devise_for :users

  resources :items, except: [:index]
  resources :carts, only: [:index]

  root to: "static_pages#home"

end
