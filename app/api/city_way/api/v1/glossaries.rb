module CityWay
  module Api
    module V1
      class Glossaries < Grape::API
        version 'v1'
        format :json

        resources :glossaries do
          before do
            authenticate!
          end

          desc "Glossary Detail"
          params do
            requires :id , type: Integer, values: -> { GarbageGlossary.ids }
          end
          get '/:id' do
            garbage = GarbageGlossary.find(params[:id])
            present garbage, with: CityWay::Api::V1::Entities::GarbageGlossary, simple: 'false'
          end
        end

      end
    end
  end
end
