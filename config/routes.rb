Rails.application.routes.draw do
  root "words#home"
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  resources :reviews
  resources :words, only: [:index, :home]
  resources :users
end
