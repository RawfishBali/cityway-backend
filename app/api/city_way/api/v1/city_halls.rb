module CityWay
  module Api
    module V1
      class CityHalls < Grape::API
        version 'v1'
        format :json

        resources :city_halls do
          before do
            authenticate!
          end

          desc "CityHall Detail"
          params do
            requires :id , type: Integer, values: -> { Commonplace.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id' do
            commonplace = Commonplace.find(params[:id])
            advertisements = commonplace.city.active_advertisements
            present commonplace, with: CityWay::Api::V1::Entities::Commonplace, simple: 'false', latitude: params[:latitude], longitude: params[:longitude], advertisements: advertisements
          end


          desc "CityHall Public Offices"
          params do
            requires :id , type: Integer, values: -> { Commonplace.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/public_offices' do
            commonplace = Commonplace.find(params[:id])
            offices = commonplace.public_offices.page params[:page]
            add_pagination_headers offices

            present offices, with: CityWay::Api::V1::Entities::PublicOffice, simple: 'true', latitude: params[:latitude], longitude: params[:longitude]
          end

          desc "CityHall Public Office Detail"
          params do
            requires :id , type: Integer, values: -> { Commonplace.ids }
            requires :public_office_id , type: Integer, values: -> { PublicOffice.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/public_offices/:public_office_id' do
            commonplace = Commonplace.find(params[:id])
            offices = commonplace.public_offices.find(params[:public_office_id])

            present offices, with: CityWay::Api::V1::Entities::PublicOffice, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
          end


          desc "CityHall Securities"
          params do
            requires :id , type: Integer, values: -> { Commonplace.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/securities' do
            commonplace = Commonplace.find(params[:id])
            securities = commonplace.securities.page params[:page]
            add_pagination_headers securities

            present securities, with: CityWay::Api::V1::Entities::Security, simple: 'false'
          end


          desc "CityHall Online Services"
          params do
            requires :id , type: Integer, values: -> { Commonplace.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/online_services' do
            commonplace = Commonplace.find(params[:id])

            present commonplace, with: CityWay::Api::V1::Entities::OnlineServices, simple: 'false'
          end

          desc "CityHall Online Services Detail"
          params do
            requires :id , type: Integer, values: -> { Commonplace.ids }
            requires :online_service_id, type: Integer, values: -> { OnlineService.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/online_services/:online_service_id' do
            commonplace = Commonplace.find(params[:id])
            online_service = commonplace.online_services.find_by(id: params[:online_service_id])

            present online_service, with: CityWay::Api::V1::Entities::OnlineService, simple: 'false'
          end

          desc "CityHall News"
          params do
            requires :id , type: Integer, values: -> { Commonplace.ids }
          end
          get '/:id/news' do
            commonplace = Commonplace.find(params[:id])
            news = commonplace.news.page params[:page]
            add_pagination_headers news

            present news, with: CityWay::Api::V1::Entities::News
          end

          desc "CityHall News Detail"
          params do
            requires :id , type: Integer, values: -> { Commonplace.ids }
            requires :news_id , type: Integer, values: -> { News.ids }
          end
          get '/:id/news/:news_id' do
            news = News.find(params[:news_id])
            present news, with: CityWay::Api::V1::Entities::News
          end

          desc "CityHall Administrations"
          params do
            requires :id , type: Integer, values: -> { Commonplace.ids }
          end
          get '/:id/administrations' do
            commonplace = Commonplace.find(params[:id])

            present commonplace, with: CityWay::Api::V1::Entities::Administration, latitude: params[:latitude], longitude: params[:longitude]
          end

          desc "CityHall Story"
          params do
            requires :id , type: Integer, values: -> { Commonplace.ids }
          end
          get '/:id/story' do
            story = Commonplace.find(params[:id]).city_hall_story
            present story, with: CityWay::Api::V1::Entities::CityHallStory
          end


        end
      end
    end
  end
end
