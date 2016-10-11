Rails.application.routes.draw do
  root "words#home"
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  resources :words, only: [:index, :home, :show, :new, :create, :edit, :update, :destroy] do
    resources :reviews
  end
  resources :users do
    member do
      delete :remove_avatar
    end
  end
  resources :search, only: [:index]
end
