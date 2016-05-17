Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :groups, only: [:new, :create, :show ]
  #get 'products/:id', to 'catalog#view'
end
