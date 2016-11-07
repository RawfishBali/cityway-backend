module CityWay
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
            categories = Category.parent_categories.page params[:page]
            add_pagination_headers categories
            present categories, with: CityWay::Api::V1::Entities::Category
          end

          desc  "List Of SubCategories"
          params do
            requires :id , type: Integer, values: -> { Category.parent_categories.ids }
          end
          get '/:id' do
            subcategories = Category.find(params[:id]).subcategories
            present subcategories, with: CityWay::Api::V1::Entities::Category
          end
        end

      end
    end
  end
end
