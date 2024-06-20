Rails.application.routes.draw do
  patch 'update_name', to: 'users#update_name'
  resources :station_logs
  # I write middle and end
  resources :station_logs do
    get 'find_device_type', on: :collection
  end
# I stop
  resources :jsontests
  resources :userzones
  resources :zones
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
  # I write


end
