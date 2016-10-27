class Admin::BaseController < ApplicationController
  # layout "admin"
  before_action :authenticate_admin!
  before_action :set_cities
  before_action :set_photo_parameters, only: [:create, :update]

  def set_cities
    @selected_city = session[:current_city_id].blank? ? City.first :  City.find(session[:current_city_id])
    @cities = City.all
  end

  def set_photo_parameters
    if params["city"]
      if params["city"]["photo"]
        unless params["city"]["photo"].class.to_s == 'ActionDispatch::Http::UploadedFile'
          image_json =  JSON.parse(params["city"]["photo"]["_values"].gsub("'",'"').gsub('=>',':'))
          params["city"]["photo"] = image_json["data"]
        end
      end

      if params["city"]["discover_attributes"]["photo"]
        unless params["city"]["discover_attributes"]["photo"].class.to_s == 'ActionDispatch::Http::UploadedFile'
          image_json =  JSON.parse(params["city"]["discover_attributes"]["photo"]["_values"].gsub("'",'"').gsub('=>',':'))
          params["city"]["discover_attributes"]["photo"] = image_json["data"]
        end
      end

      if params["city"]["around_attributes"]["photo"]
        unless params["city"]["around_attributes"]["photo"].class.to_s == 'ActionDispatch::Http::UploadedFile'
          image_json =  JSON.parse(params["city"]["around_attributes"]["photo"]["_values"].gsub("'",'"').gsub('=>',':'))
          params["city"]["around_attributes"]["photo"] = image_json["data"]
        end
      end

      if params["city"]["commonplace_attributes"]["photo"]
        unless params["city"]["commonplace_attributes"]["photo"].class.to_s == 'ActionDispatch::Http::UploadedFile'
          image_json =  JSON.parse(params["city"]["commonplace_attributes"]["photo"]["_values"].gsub("'",'"').gsub('=>',':'))
          params["city"]["commonplace_attributes"]["photo"] = image_json["data"]
        end
      end

      if params["city"]["utility_attributes"]["photo"]
        unless params["city"]["utility_attributes"]["photo"].class.to_s == 'ActionDispatch::Http::UploadedFile'
          image_json =  JSON.parse(params["city"]["utility_attributes"]["photo"]["_values"].gsub("'",'"').gsub('=>',':'))
          params["city"]["utility_attributes"]["photo"] = image_json["data"]
        end
      end
    end

    if params["category"]
      if params["category"]["photo"]
        unless params["category"]["photo"].class.to_s == 'ActionDispatch::Http::UploadedFile'
          image_json =  JSON.parse(params["category"]["photo"]["_values"].gsub("'",'"').gsub('=>',':'))
          params["category"]["photo"] = image_json["data"]
        end
      end
      if params["category"]["icon"]
        unless params["category"]["icon"].class.to_s == 'ActionDispatch::Http::UploadedFile'
          image_json =  JSON.parse(params["category"]["icon"]["_values"].gsub("'",'"').gsub('=>',':'))
          params["category"]["icon"] = image_json["data"]
        end
      end
    end

    if params["merchant"]
      if params["merchant"]["icon"]
        unless params["merchant"]["icon"].class.to_s == 'ActionDispatch::Http::UploadedFile'
          image_json =  JSON.parse(params["merchant"]["icon"]["_values"].gsub("'",'"').gsub('=>',':'))
          params["merchant"]["icon"] = image_json["data"]
        end
      end

      if params["merchant"]["photos_attributes"]
        params["merchant"]["photos_attributes"].each do |photo_params|
          if photo_params.last["picture"].class.to_s != 'ActionDispatch::Http::UploadedFile' && !photo_params.last["picture"].blank?
            image_json =  JSON.parse(photo_params.last["picture"]["_values"].gsub("'",'"').gsub('=>',':'))
            photo_params.last["picture"] = image_json["data"]
          end
        end
      end
    end

    if params["promo"]
      if params["promo"]["photo"]
        unless params["promo"]["photo"].class.to_s == 'ActionDispatch::Http::UploadedFile'
          image_json =  JSON.parse(params["promo"]["photo"]["_values"].gsub("'",'"').gsub('=>',':'))
          params["promo"]["photo"] = image_json["data"]
        end
      end
    end

    if params["place"]
      if params["place"]["photos_attributes"]
        params["place"]["photos_attributes"].each do |photo_params|
          if photo_params.last["picture"].class.to_s != 'ActionDispatch::Http::UploadedFile' && !photo_params.last["picture"].blank?
            image_json =  JSON.parse(photo_params.last["picture"]["_values"].gsub("'",'"').gsub('=>',':'))
            photo_params.last["picture"] = image_json["data"]
          end
        end
      end
    end
  end


end
