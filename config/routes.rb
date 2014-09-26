require 'sidekiq/web'

Rails.application.routes.draw do



  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :items, except: [:index]

  post '/changerole' => 'changerole#update'

  get '/cart', to: 'carts#show'
  get '/cart/add', to: 'carts#add'
  get '/cart/remove', to: 'carts#remove'
  get '/cart/checkout', to: 'carts#checkout'

  resources :invoices, only: [:show] do
    member do
      post :close
    end
  end

  root to: "static_pages#home"

  # authenticate :user, lambda { |u| u.admin? } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
end
