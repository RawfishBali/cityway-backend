Rails.application.routes.draw do
  get '/ping', to: proc { [200, {}, ['']] }
  get '/attivita', to: 'home#attivita'

  devise_for :admins
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  # use_doorkeeper




  root 'home#index'

  namespace :admin do

  end

  # mount CityView::Haha => '/api'
  mount CityView::Api::V1::Base => '/api'
end
