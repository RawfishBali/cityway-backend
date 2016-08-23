# == Schema Information
#
# Table name: advertisements_cities
#
#  id               :integer          not null, primary key
#  city_id          :integer          not null
#  advertisement_id :integer          not null
#

class AdvertisementsCity < ActiveRecord::Base
  belongs_to :advertisement
  belongs_to :city
end
