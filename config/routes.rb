Rails.application.routes.draw do
  root "words#home"
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions', omniauth_callbacks: 'callbacks' }
  resources :words, only: [:index, :home, :show, :new, :create, :edit, :update, :destroy] do
    resources :reviews do
      resources :votes, only: [:create]
    end
  end
  resources :users do
    member do
      delete :remove_avatar
    end
  end
  resources :search, only: [:index]
end
