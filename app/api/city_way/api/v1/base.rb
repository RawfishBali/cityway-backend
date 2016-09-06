require 'client_application'
require 'access_token'
# require 'gcfs/oauth2/failure_app'

module StrongParamsHelpers
  extend Grape::API::Helpers

  def permitted_params
    @permitted_params ||= declared(params, include_missing: false, include_parent_namespaces: false)
  end
end

module CityWay
  module Api
    module V1
      class Base < Grape::API
        helpers StrongParamsHelpers
        version 'v1', using: :path
        format :json

        use Warden::Manager do |config|
          config.strategies.add :bearer, Warden::OAuth2::Strategies::Bearer
          config.strategies.add :client, Warden::OAuth2::Strategies::Client

          config.default_strategies :bearer, :client
          config.failure_app = Warden::OAuth2::FailureApp
        end

        helpers do
          def warden; env['warden'] end

          def authenticate!
            warden.authenticate! scope: :offline_access
          end

          def current_access_token
            authenticate!
          end

          def current_user
            current_access_token.user
          end

          def current_client_application
            current_access_token.client_application
          end

          def current_client
            current_access_token.client_application
          end

          def add_pagination_headers data
            header "X-Total",       data.total_count.to_s
            header "X-Total-Pages", data.total_pages.to_s
            header "X-Per-Page",    (params[:per_page].presence || Kaminari.config.default_per_page).to_s
            header "X-Page",        data.current_page.to_s
            header "X-Next-Page",   data.next_page.to_s
            header "X-Prev-Page",   data.prev_page.to_s
          end

          def only_admin_user
            error!({error: "invalid_request"}, 400) and return unless current_user
            error!({error: "invalid_request"}, 400) and return if current_user and !current_user.administrator?
          end
          def action_description
            self.route.instance_variables.map{|v| instance_variable_get(v)}.last[:route_options][:description]
          end
          def validate_date(date_str, valid_formats=nil)
            valid_formats = ["%Y-%m-%d %H:%M:%S"] unless valid_formats

            valid_formats.each do |format|
              valid = Time.strptime(date_str, format) rescue false

              return true if valid
            end

            return false
          end
        end

        desc "API Status"
        get :status do
          authenticate!
          {message: "Up to date"}
        end

        mount CityWay::Api::V1::Token
        mount CityWay::Api::V1::Cities
        mount CityWay::Api::V1::Users
        mount CityWay::Api::V1::Attivitas
        mount CityWay::Api::V1::Categories
        mount CityWay::Api::V1::Arounds
        mount CityWay::Api::V1::Merchants
        mount CityWay::Api::V1::Promos
        mount CityWay::Api::V1::Events
        mount CityWay::Api::V1::Markets
        mount CityWay::Api::V1::Parks
      end
    end
  end
end
