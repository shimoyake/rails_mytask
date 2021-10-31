Rails.application.routes.draw do
  
  devise_for :users
  
  #トップページ
  root 'pages#index'
  get 'pages/show'
  
  #user
  resources :users
  resources :rooms
  
  #ルーム
  get 'rooms/index'
  post 'rooms', to: 'rooms#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
