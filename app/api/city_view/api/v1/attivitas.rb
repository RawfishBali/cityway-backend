module CityView
  module Api
    module V1
      class Attivitas < Grape::API
        version 'v1'
        format :json

        resources :attivitas do
          before do
            authenticate!
          end

          desc  "List Of Attivita Of City Per Category Or All"
          params do
            requires :city_id, type: Integer, desc: "City ID", values: -> { City.ids }
            optional :category_id, type: Integer, desc: "Category ID", values: -> { Category.ids }
          end
          get do
            city = City.find(params[:city_id])
            if params[:category_id]
              merchants = Merchant.joins(:categories).where('categories.id = ? and merchants.city_id = ?', params[:category_id], params[:city_id]).page params[:page]
            else
              merchants = Merchant.where('merchants.city_id = ?', params[:city_id]).page params[:page]
            end

            add_pagination_headers merchants
            present merchants, with: CityView::Api::V1::Entities::Merchant
          end


          desc  "Show Attivita"
          params do
            requires :id, type: Integer, desc: "Merchant ID", values: -> { Merchant.ids }
          end
          get '/:id' do
            merchant = Merchant.find(params[:id])

            present merchant, with: CityView::Api::V1::Entities::Merchant
          end

        end

      end
    end
  end
end
