Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  resources :users
  # get    'users'          => 'users#index'
  # post   'users'          => 'users#create'
  # get    'users/new'      => 'users#new'
  # get    'users/:id/edit' => 'users#edit'
  # get    'users/:id'      => 'users#show'
  # patch  'users/:id'      => 'users#update'
  # put    'users/:id'      => 'users#update'
  # delete 'users/:id'      => 'users#destroy'
end
