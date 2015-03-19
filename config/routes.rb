Rails.application.routes.draw do
  resources :performances

  resources :stages

  resources :artists

  resources :cities

  resources :countries

  resources :events

  resources :venues

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
