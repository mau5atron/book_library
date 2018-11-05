require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  resources :books do
  	member do 
  		put 'add', to: 'books#library'
  		put 'remove', to: 'books#library'
  	end
  end
  root to: 'home#index'
end
