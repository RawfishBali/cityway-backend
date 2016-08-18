Rails.application.routes.draw do
  get '/ping', to: proc { [200, {}, ['']] }

  devise_for :admins
  devise_for :users

  root 'home#index'

  namespace :admin do
    resources :cities
    resources :commonplaces
  end

  mount CityWay::Api::V1::Base => '/api'
end
