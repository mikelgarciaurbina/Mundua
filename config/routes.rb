Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root 'home#index'

  devise_for :users

  resources :groups, only: [ :new, :create ]
  get '/group', to: 'groups#show'
  post '/join-group', to: 'groups#join_group'
  resources :houses, only: [ :new, :create, :show ]
  get '/my-houses', to: 'houses#my_houses'
  get '/group-house', to: 'houses#group_house'
  post '/join-house', to: 'houses#join_house'
  resources :users, only: [ :edit, :update ]
  get '/profile', to: 'users#profile'
  get '/search', to: 'searches#search'

  namespace :api do
    namespace :v1 do
      resources :houses, only: [:index]
    end
  end
end
