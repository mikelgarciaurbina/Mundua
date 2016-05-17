Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :groups, only: [ :new, :create, :show ]
  resources :houses, only: [ :new, :create, :show ]
  resources :users, only: [ :edit, :update ]
  get '/profile', to: 'users#profile'
end
