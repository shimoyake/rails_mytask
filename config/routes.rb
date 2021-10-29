Rails.application.routes.draw do

  devise_for :users, module: "users"
  
  root 'pages#index'
  get 'pages/show'
  
  resources :users
  resources :rooms
  
  #get 'rooms/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
