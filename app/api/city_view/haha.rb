require 'doorkeeper/grape/helpers'

module CityView
    class Haha < Grape::API
      version 'v1', using: :path
      format :json
      rescue_from :all

      helpers Doorkeeper::Grape::Helpers

      before do
        doorkeeper_authorize!
      end

      resource :haha do
        params do

        end
        get :all do

          {
            message: "It's working!",
            status: 200
          }

        end
      end
    end
end
