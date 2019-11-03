Rails.application.routes.draw do
 
  #static pages controller
  get '/contact', to: 'static_pages#contact'
  get '/team', to: 'static_pages#team'
  root 'gossips#index'

  #gossip controller 
  resources :gossips

  #user controller
  resources :users
  
  #cities controller
  resources :cities

  #comments controller
  resources :gossips do
    resources :comments
  end
  
  #sessions controller
  resources :sessions, only: [:new, :create, :destroy]
end