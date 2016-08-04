Rails.application.routes.draw do
  get '/ping', to: proc { [200, {}, ['']] }

  devise_for :admins

  root 'home#index'

  namespace :admin do
    resources :cities
  end

  # mount CityView::Haha => '/api'
  mount CityView::Api::V1::Base => '/api'
end
