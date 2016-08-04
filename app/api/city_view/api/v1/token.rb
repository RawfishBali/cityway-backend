module CityView
  module Api
    module V1
      class Token < Grape::API
        version 'v1', using: :path do
          format :json

          before do
            authenticate!
          end

          helpers do
            def current_client
              authenticate!
            end
          end

        end
      end
    end
  end
end
