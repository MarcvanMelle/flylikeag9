Rails.application.routes.draw do
  root "words#index"
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :reviews
  resources :words, only: [:index]
  resources :users
end
