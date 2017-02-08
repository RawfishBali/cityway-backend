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
#  predifined :boolean          default(FALSE)
#

class Category < ActiveRecord::Base
  has_many :subcategories , -> { order 'name asc' }, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  accepts_nested_attributes_for :subcategories, reject_if: :all_blank, allow_destroy: true
  belongs_to :parent_category, :class_name => "Category", :foreign_key => "parent_id"
  has_many :merchants, dependent: :nullify

  has_many :cities, through: :categories_cities
  has_many :categories_cities, dependent: :destroy

  # validates :name, uniqueness: {scope: :parent_id, allow_blank: false}
  # validates :photo, presence: true, if: :parent_id?
  # validates :icon, presence: true, if: :parent_id?

  scope :subcategories, -> { where("parent_id IS NOT NULL") }
  scope :parent_categories, -> { where("parent_id IS NULL") }

  mount_base64_uploader :photo, PhotoUploader
  mount_base64_uploader :icon, PhotoUploader

  def self.order_by_ids(ids)
    order_by = ["case"]
    ids.each_with_index.map do |id, index|
      order_by << "WHEN categories.id='#{id}' THEN #{index}"
    end
    order_by << "end"
    order(order_by.join(" "))
  end
end
