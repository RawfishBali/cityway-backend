module CityWay
  module Api
    module V1
      class Splashes < Grape::API
        version 'v1'
        format :json

        resources :splashes do
          before do
            authenticate!
          end

          desc "Splash!"
          params do

          end
          get  do
            splash = Wizard.all.order('created_at DESC').first
            present splash, with: CityWay::Api::V1::Entities::Splash
          end
        end

      end
    end
  end
end
