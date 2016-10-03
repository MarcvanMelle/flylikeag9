Rails.application.routes.draw do

  root "words#index"
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :reviews
  resources :words
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
