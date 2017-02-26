Rails.application.routes.draw do
  namespace :api do
  get 'pokemon/index'
  end

  namespace :api do
  get 'pokemon/show'
  end

  get 'index/show'

  root to: 'static_pages#root'

  namespace :api, defaults: {format: :json} do
    resources :pokemon, except: [:new, :edit]
  end
end
