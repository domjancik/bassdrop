Rails.application.routes.draw do
  concern :playlistable do
    member do
      post 'create_playlist'
    end
  end

  concern :publishable do
    member do
      post 'publish'
      post 'hide'
    end
  end

  resources :stories, concerns: [:playlistable, :publishable]

  resources :playlists, concerns: :playlistable do
    resources :playlist_items, shallow: true, path: 'items'
    member do
      get 'open(/:item_id)', action: 'open', as: 'open'
    end
  end

  resources :media

  resources :releases, concerns: :playlistable do
    resources :credits, shallow: true
  end

  get 'records', controller: :releases
  get 'sets', controller: :releases
  get 'videos', controller: :releases

  resources :events, concerns: [:playlistable, :publishable] do
    resources :performances, shallow: true
  end

  resources :stages

  resources :artists, concerns: :playlistable

  resources :cities

  resources :countries

  resources :venues

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
