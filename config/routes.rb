Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root 'home#index'

  devise_for :users

  resources :groups, only: [ :new, :create, :update ]
  get '/group', to: 'groups#show', as: 'show_group'
  get '/group-edit', to: 'groups#edit'
  post '/join-group', to: 'groups#join_group'
  get '/accept-group/:user', to: 'groups#accept_user'
  get '/reject-group/:user', to: 'groups#reject_user'
  resources :houses, only: [ :new, :create, :show ]
  get '/my-houses', to: 'houses#my_houses'
  get '/group-house', to: 'houses#group_house'
  post '/join-house', to: 'houses#join_house'
  resources :users, only: [ :edit, :update ]
  get '/profile', to: 'users#profile'
  get '/change_password', to: 'users#change_password'
  patch '/update_password', to: 'users#update_password'
  get '/search', to: 'searches#search'
  resources :technologies, only: [ :create ]
  resources :hobbies, only: [ :create ]

  namespace :api do
    namespace :v1 do
      resources :houses, only: [:index]
      resources :technologies, only: [:index]
      resources :hobbies, only: [:index]
    end
  end
end
