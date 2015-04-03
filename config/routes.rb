Rails.application.routes.draw do
  resources :playlists do
    resources :playlist_items, shallow: true, path: 'items'
    member do
      post 'create_playlist'
      get 'open(/:item_id)', action: 'open', as: 'open'
    end
  end

  resources :media

  resources :credits

  resources :releases do
    member do
      post 'create_playlist'
    end
  end

  resources :events do
    resources :performances, shallow: true
    member do
      post 'create_playlist'
    end
  end

  resources :stages

  resources :artists

  resources :cities

  resources :countries

  resources :venues

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
