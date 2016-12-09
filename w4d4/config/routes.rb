Rails.application.routes.draw do
  root 'sessions#index'
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    resources :albums, only: [:new]
  end
  resources :albums, except: [:new] do
    resources :tracks, only: [:new]
  end

  resources :tracks, except: [:new] do
    resources :notes, only: [:index]
  end

  resources :notes, only: [:edit, :destroy, :update, :create]
end
