Rails.application.routes.draw do
  namespace :admin do
    resources :advertisements
    resources :categories
    resources :cities
    resources :commonplaces
    resources :merchants
    resources :promos
  end
  
  get '/ping', to: proc { [200, {}, ['']] }

  devise_for :admins
  devise_for :users

  root 'home#index'

  mount CityWay::Api::V1::Base => '/api'
end
