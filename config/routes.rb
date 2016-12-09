Rails.application.routes.draw do
  resources :users
  resources :subs
  resources :posts, except: [:index]
  resource :session, except: [:index, :update, :edit, :show]
end
