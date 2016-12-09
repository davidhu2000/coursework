Rails.application.routes.draw do
  resources :users
  resources :subs
  resource :session, except: [:index, :update, :edit, :show]
end
