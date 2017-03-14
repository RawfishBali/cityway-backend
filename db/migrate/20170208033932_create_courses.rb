class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, null:false
      t.string :denomination
      t.text :description
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :email
      t.string :phone
      t.string :phone_1
      t.string :phone_2
      t.string :website
      t.integer :utility_id
      t.boolean :support_disabilities, default:false
      t.string :facebook
      t.string :instagram
      t.string :twitter
      t.string :google_plus
      t.string :course_type
      t.timestamps null: false
    end
  end
end
