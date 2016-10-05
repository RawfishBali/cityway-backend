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
#  icon       :string
#

class Category < ActiveRecord::Base
  has_many :subcategories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  accepts_nested_attributes_for :subcategories, reject_if: :all_blank, allow_destroy: true
  belongs_to :parent_category, :class_name => "Category", :foreign_key => "parent_id"
  has_many :merchants, dependent: :nullify

  has_many :cities, through: :categories_cities
  has_many :categories_cities, dependent: :destroy

  validates :name, uniqueness: {scope: :parent_id, allow_blank: false}
  # validates :photo, presence: true, if: :parent_id?
  # validates :icon, presence: true, if: :parent_id?

  scope :subcategories, -> { where("parent_id IS NOT NULL") }
  scope :parent_categories, -> { where("parent_id IS NULL") }

  mount_uploader :photo, PhotoUploader
  mount_uploader :icon, PhotoUploader
end
