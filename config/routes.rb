Rails.application.routes.draw do
  resources :images do
    member do
      get 'reveal', as: :reveal
    end
  end

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

  concern :pagable do
    collection do
      get 'page(/:page)', defaults: { page: '0' }, action: :index, as: :page
    end
  end

  get '/fb', to: redirect('https://www.facebook.com/bassdropcz'), as: :fb

  scope '(:locale)', locale: /cs|en/ do
    resources :stories, concerns: [:playlistable, :publishable, :pagable]

    resources :playlists, concerns: :playlistable do
      resources :playlist_items, shallow: true, path: 'items'
      member do
        get 'open(/:item_id)', action: 'open', as: 'open'
      end
    end

    resources :media

    resources :releases, concerns: :playlistable do
      member do
        get 'avatars', action: :avatars, as: 'avatars'
      end
      resources :credits, shallow: true
    end

    get 'records', controller: :releases
    get 'sets', controller: :releases
    get 'videos', controller: :releases

    get 'next', action: :next, controller: :events

    resources :events, concerns: [:playlistable, :publishable] do
      resources :performances, shallow: true
      collection do
        get 'year(/:year)', defaults: { year: '2015' }, action: :year, as: :year
      end
    end

    resources :stages

    get 'team', controller: :artists, as: :team

    resources :artists, concerns: :playlistable

    resources :cities

    resources :countries

    resources :venues
  end

  mount Upmin::Engine => '/admin'

  devise_for :users
  resources :users

  get '/:locale' => 'visitors#index', as: :locale
  root to: 'visitors#index'
end
