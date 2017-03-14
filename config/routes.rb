Rails.application.routes.draw do
  namespace :admin do
    resources :advertisements
    resources :categories do
      collection do
        post 'order'
      end
    end
    resources :cities
    resources :commonplaces
    resources :merchants do
      member do
        post 'remove_icon'
      end
    end
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
    resources :ztls
    resources :waste_types
    resources :waste_managements
    resources :certificates
    resources :sports
    resources :schools
    resources :parking_lots
    resources :courses
  end

  get '/ping', to: proc { [200, {}, ['']] }

  devise_for :admins
  devise_for :users, controllers: {passwords: "user/passwords"}

  root 'home#index'

  mount CityWay::Api::V1::Base => '/api'
end
