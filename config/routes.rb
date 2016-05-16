Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  #get 'products/:id', to 'catalog#view'
end
