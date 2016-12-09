Rails.application.routes.draw do
  resources :users
  resource :session, except: [:index, :update, :edit, :show]
end
