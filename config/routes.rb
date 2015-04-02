Rails.application.routes.draw do
  resources :media

  resources :release_media

  resources :credits

  resources :releases

  resources :events do
    resources :performances, shallow: true
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
