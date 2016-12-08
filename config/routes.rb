Rails.application.routes.draw do
  root 'sessions#index'
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
end
