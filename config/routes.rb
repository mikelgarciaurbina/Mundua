Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root 'home#index'

  devise_for :users

  resources :groups, only: [ :new, :create, :update, :destroy ]
  get '/group', to: 'groups#show', as: 'show_group'
  get '/group-edit', to: 'groups#edit'
  post '/join-group', to: 'groups#join_group'
  get '/accept-user/:user', to: 'groups#accept_user'
  get '/reject-user/:user', to: 'groups#reject_user'
  delete '/delete-user/:user', to: 'groups#delete_user', as: 'delete_user_from_group'
  resources :houses, except: [ :index ]
  get '/my-houses', to: 'houses#my_houses'
  get '/group-house', to: 'houses#group_house'
  post '/join-house', to: 'houses#join_house'
  get '/houses/:id/accept-group/:group', to: 'houses#accept_group'
  get '/houses/:id/reject-group/:group', to: 'houses#reject_group'
  delete '/houses/:id/delete-group/:group', to: 'houses#delete_group', as: 'delete_group_from_house'
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
      get '/nomadlist', to: 'nomadlist#index'
    end
  end
end
