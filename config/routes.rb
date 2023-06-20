Rails.application.routes.draw do
  resources :users
  resources :wlans
  mount API::Base, at: "/"
  resources :wificlients
  devise_for :managers
  resources :accounts
  resources :owners
  
  #get 'home/index'
  get 'home/about'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
