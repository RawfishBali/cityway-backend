Rails.application.routes.draw do
  get '/ping', to: proc { [200, {}, ['']] }

  devise_for :admins
  devise_for :users
  use_doorkeeper


  root 'home#index'

  namespace :admin do

  end

  mount CityView::Haha => '/api'
end
