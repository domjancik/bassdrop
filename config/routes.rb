Rails.application.routes.draw do
  resources :playlists do
    resources :playlist_items, shallow: true, path: 'items'
    member do
      post 'create_playlist'
      get 'open(/:item_id)', action: 'open', as: 'open'
    end
  end

  resources :media

  resources :releases do
    resources :credits, shallow: true
    member do
      post 'create_playlist'
    end
  end

  get 'records', controller: :releases
  get 'sets', controller: :releases

  resources :events do
    resources :performances, shallow: true
    member do
      post 'create_playlist'
      post 'publish'
      post 'hide'
    end
  end

  resources :stages

  resources :artists do
    member do
      post 'create_playlist'
    end
  end

  resources :cities

  resources :countries

  resources :venues

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
