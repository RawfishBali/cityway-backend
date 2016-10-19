Rails.application.routes.draw do

  namespace :admin do
    resources :advertisements
    resources :categories
    resources :cities
    resources :commonplaces
    resources :merchants
    resources :promos
    resources :parks
    resources :markets
    resources :events
    resources :places
    resources :itineraries
    resources :culinaries
    resources :splashes
    resources :stories
    resources :city_hall_stories
    resources :news
    resources :public_offices
    resources :securities
    resources :online_services
    resources :politic_groups
    resources :profiles
    resources :devices
    resources :utility_numbers
    resources :utility_places
    resources :vehicles
    resources :public_transports
  end

  get '/ping', to: proc { [200, {}, ['']] }

  devise_for :admins
  devise_for :users, controllers: {passwords: "user/passwords"}

  root 'home#index'

  mount CityWay::Api::V1::Base => '/api'
end
