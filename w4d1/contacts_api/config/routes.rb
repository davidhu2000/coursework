Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  resources :users, only: [:index, :show, :create, :update, :destroy] do
    resources :contacts, only: [:index]
    resources :comments, only: [:index]
    member do
      get 'favorites'
      post 'favorite/:id', to: 'contacts#favorite'
    end
  end

  resources :contacts, except: [:index, :new, :edit] do
    resources :comments, only: [:index]

    member do
      post 'favorite'
    end
  end

  resources :contact_shares, only: [:create, :destroy]

  resources :comments, only: [:create, :destroy]
end
