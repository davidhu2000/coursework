Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  resources :users, only: [:index, :show, :create, :update, :destroy] do
    resources :contacts, only: [:index]
  end
  resources :contacts, except: [:index, :new, :edit]
  resources :contact_shares, only: [:create, :destroy]
end
