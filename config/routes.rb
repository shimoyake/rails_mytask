Rails.application.routes.draw do
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  devise_for :users

  
  #トップページ
  root 'pages#index'
  get 'pages/show'
  
  #user
  resources :users
  resources :rooms
  resources :reserves
  
  #ルーム
  get 'rooms/index'
  post 'rooms', to: 'rooms#create'
  get 'rooms/show'
  
  get 'reserves/index'
  #post 'reserves', to: 'reserves#create'
  
  post 'reserves/confirm', to: 'reserves#confirm'
  
  patch '/reserves', to: 'reserves#create'
  #get 'reserves/new', to: 'reserves#update'
  
  #予約確認
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
