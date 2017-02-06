class Admin::BaseController < ApplicationController
  # layout "admin"
  before_action :authenticate_admin!
  # before_action :check_roles
  before_action :set_cities
  before_action :set_photo_parameters, only: [:create, :update]
  before_action :save_previous_url, only: [:new, :edit, :destroy]

  # def check_roles
  #   valid = true
  #   unless controller_name == 'home'
  #     unless current_admin.has_role?(:merchant_admin)
  #       if controller_name ==  "merchants" && action_name == 'edit'
  #         puts "------------------------"
  #         puts current_admin.merchant.id == params[:id]
  #         puts current_admin.merchant.id
  #         puts params[:id]
  #         puts "------------------------"
  #         unless current_admin.merchant.id == params[:id].to_i
  #           valid = false
  #         end
  #       elsif controller_name ==  "promos" && action_name == 'edit'
  #         unless current_admin.merchant.promos.map(&:id).include? params[:id].to_i
  #           valid = false
  #         end
  #       else
  #         valid = false
  #       end
  #       unless valid
  #         flash[:notice] = 'Accesso Vietato'
  #         return redirect_to root_path
  #       end
  #     end
  #   end
  #
  # end

  def set_cities
    begin
      @selected_city = session[:current_city_id].blank? ? City.first :  City.find(session[:current_city_id])
      @cities = City.all
    rescue ActiveRecord::RecordNotFound => exception
      @selected_city = City.first
      @cities = City.all
    end
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

    if params["culinary"]
      if params["culinary"]["photos_attributes"]
        params["culinary"]["photos_attributes"].each do |photo_params|
          if photo_params.last["picture"].class.to_s != 'ActionDispatch::Http::UploadedFile' && !photo_params.last["picture"].blank?
            image_json =  JSON.parse(photo_params.last["picture"]["_values"].gsub("'",'"').gsub('=>',':'))
            photo_params.last["picture"] = image_json["data"]
          end
        end
      end
    end

    if params["story"]
      if params["story"]["photos_attributes"]
        params["story"]["photos_attributes"].each do |photo_params|
          if photo_params.last["picture"].class.to_s != 'ActionDispatch::Http::UploadedFile' && !photo_params.last["picture"].blank?
            image_json =  JSON.parse(photo_params.last["picture"]["_values"].gsub("'",'"').gsub('=>',':'))
            photo_params.last["picture"] = image_json["data"]
          end
        end
      end
    end

    if params["itinerary"]
      if params["itinerary"]["photos_attributes"]
        params["itinerary"]["photos_attributes"].each do |photo_params|
          if photo_params.last["picture"].class.to_s != 'ActionDispatch::Http::UploadedFile' && !photo_params.last["picture"].blank?
            image_json =  JSON.parse(photo_params.last["picture"]["_values"].gsub("'",'"').gsub('=>',':'))
            photo_params.last["picture"] = image_json["data"]
          end
        end
      end
    end

    if params["event"]
      if params["event"]["photos_attributes"]
        params["event"]["photos_attributes"].each do |photo_params|
          if photo_params.last["picture"].class.to_s != 'ActionDispatch::Http::UploadedFile' && !photo_params.last["picture"].blank?
            image_json =  JSON.parse(photo_params.last["picture"]["_values"].gsub("'",'"').gsub('=>',':'))
            photo_params.last["picture"] = image_json["data"]
          end
        end
      end
    end

    if params["market"]
      if params["market"]["photos_attributes"]
        params["market"]["photos_attributes"].each do |photo_params|
          if photo_params.last["picture"].class.to_s != 'ActionDispatch::Http::UploadedFile' && !photo_params.last["picture"].blank?
            image_json =  JSON.parse(photo_params.last["picture"]["_values"].gsub("'",'"').gsub('=>',':'))
            photo_params.last["picture"] = image_json["data"]
          end
        end
      end
    end

    if params["park"]
      if params["park"]["photos_attributes"]
        params["park"]["photos_attributes"].each do |photo_params|
          if photo_params.last["picture"].class.to_s != 'ActionDispatch::Http::UploadedFile' && !photo_params.last["picture"].blank?
            image_json =  JSON.parse(photo_params.last["picture"]["_values"].gsub("'",'"').gsub('=>',':'))
            photo_params.last["picture"] = image_json["data"]
          end
        end
      end
    end

    if params["news"]
      if params["news"]["photos_attributes"]
        params["news"]["photos_attributes"].each do |photo_params|
          if photo_params.last["picture"].class.to_s != 'ActionDispatch::Http::UploadedFile' && !photo_params.last["picture"].blank?
            image_json =  JSON.parse(photo_params.last["picture"]["_values"].gsub("'",'"').gsub('=>',':'))
            photo_params.last["picture"] = image_json["data"]
          end
        end
      end
    end

    if params["city_hall_story"]
      if params["city_hall_story"]["photos_attributes"]
        params["city_hall_story"]["photos_attributes"].each do |photo_params|
          if photo_params.last["picture"].class.to_s != 'ActionDispatch::Http::UploadedFile' && !photo_params.last["picture"].blank?
            image_json =  JSON.parse(photo_params.last["picture"]["_values"].gsub("'",'"').gsub('=>',':'))
            photo_params.last["picture"] = image_json["data"]
          end
        end
      end
    end

    if params["profile"]
      if params["profile"]["photo"]
        unless params["profile"]["photo"].class.to_s == 'ActionDispatch::Http::UploadedFile'
          image_json =  JSON.parse(params["profile"]["photo"]["_values"].gsub("'",'"').gsub('=>',':'))
          params["profile"]["photo"] = image_json["data"]
        end
      end
      if params["profile"]["major_icon"]
        unless params["profile"]["major_icon"].class.to_s == 'ActionDispatch::Http::UploadedFile'
          image_json =  JSON.parse(params["profile"]["major_icon"]["_values"].gsub("'",'"').gsub('=>',':'))
          params["profile"]["major_icon"] = image_json["data"]
        end
      end
    end

    if params["public_office"]
      if params["public_office"]["photos_attributes"]
        params["public_office"]["photos_attributes"].each do |photo_params|
          if photo_params.last["picture"].class.to_s != 'ActionDispatch::Http::UploadedFile' && !photo_params.last["picture"].blank?
            image_json =  JSON.parse(photo_params.last["picture"]["_values"].gsub("'",'"').gsub('=>',':'))
            photo_params.last["picture"] = image_json["data"]
          end
        end
      end
    end

    if params["utility_place"]
      if params["utility_place"]["photos_attributes"]
        params["utility_place"]["photos_attributes"].each do |photo_params|
          if photo_params.last["picture"].class.to_s != 'ActionDispatch::Http::UploadedFile' && !photo_params.last["picture"].blank?
            image_json =  JSON.parse(photo_params.last["picture"]["_values"].gsub("'",'"').gsub('=>',':'))
            photo_params.last["picture"] = image_json["data"]
          end
        end
      end
    end


    if params["school"]
      if params["school"]["photos_attributes"]
        params["school"]["photos_attributes"].each do |photo_params|
          if photo_params.last["picture"].class.to_s != 'ActionDispatch::Http::UploadedFile' && !photo_params.last["picture"].blank?
            image_json =  JSON.parse(photo_params.last["picture"]["_values"].gsub("'",'"').gsub('=>',':'))
            photo_params.last["picture"] = image_json["data"]
          end
        end
      end
    end

    if params["sport"]
      if params["sport"]["photos_attributes"]
        params["sport"]["photos_attributes"].each do |photo_params|
          if photo_params.last["picture"].class.to_s != 'ActionDispatch::Http::UploadedFile' && !photo_params.last["picture"].blank?
            image_json =  JSON.parse(photo_params.last["picture"]["_values"].gsub("'",'"').gsub('=>',':'))
            photo_params.last["picture"] = image_json["data"]
          end
        end
      end
    end

    if params["advertisement"]
      if params["advertisement"]["photo"]
        unless params["advertisement"]["photo"].class.to_s == 'ActionDispatch::Http::UploadedFile'
          image_json =  JSON.parse(params["advertisement"]["photo"]["_values"].gsub("'",'"').gsub('=>',':'))
          params["advertisement"]["photo"] = image_json["data"]
        end
      end
    end

    if params["commonplace"]
      if params["commonplace"]["icon"]
        unless params["commonplace"]["icon"].class.to_s == 'ActionDispatch::Http::UploadedFile'
          image_json =  JSON.parse(params["commonplace"]["icon"]["_values"].gsub("'",'"').gsub('=>',':'))
          params["commonplace"]["icon"] = image_json["data"]
        end
      end
    end

  end

  def save_previous_url
    session['previous_url'] = request.referer
  end
end
