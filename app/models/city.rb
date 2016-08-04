# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  lat        :float            not null
#  long       :float            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class City < ActiveRecord::Base
  # acts_as_mappable :default_units => :kms,
  #                  :default_formula => :sphere,
  #                  :distance_field_name => :distance,
  #                  :lat_column_name => :lat,
  #                  :lng_column_name => :long
  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  reverse_geocoded_by :lat, :long
  after_validation :reverse_geocode  # auto-fetch address

end
