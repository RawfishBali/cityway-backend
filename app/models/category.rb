# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  photo      :string
#

class Category < ActiveRecord::Base
  has_many :subcategories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent_category, :class_name => "Category", :foreign_key => "parent_id"
  has_many :merchants, dependent: :nullify

  has_many :cities, through: :categories_cities
  has_many :categories_cities

  validates :name, uniqueness: {scope: :parent_id, allow_blank: false}

  scope :subcategories, -> { where("parent_id IS NOT NULL") }
  scope :parent_categories, -> { where("parent_id IS NULL") }
end
