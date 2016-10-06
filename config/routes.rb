Rails.application.routes.draw do
  root "words#home"
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  resources :words, only: [:index, :home, :show, :edit, :update, :destroy] do
    resources :reviews
  end
  resources :users
end
