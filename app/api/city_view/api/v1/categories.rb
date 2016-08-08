module CityView
  module Api
    module V1
      class Categories < Grape::API
        version 'v1'
        format :json

        resources :categories do
          before do
            authenticate!
          end

          desc  "List Of Categories"
          params do

          end
          get do
            categories = Category.all.page params[:page]
            add_pagination_headers categories
            present categories, with: CityView::Api::V1::Entities::Category
          end
        end

      end
    end
  end
end
