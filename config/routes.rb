Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :groups, only: [ :new, :create ]
  get '/group', to: 'groups#show'
  resources :houses, only: [ :new, :create ]
  get '/my-houses', to: 'houses#myHouses'
  get '/group-house', to: 'houses#groupHouse'
  resources :users, only: [ :edit, :update ]
  get '/profile', to: 'users#profile'
end
