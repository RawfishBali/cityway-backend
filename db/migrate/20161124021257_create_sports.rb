class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string     :name
      t.string     :denomination
      t.text       :description
      t.string     :address
      t.float      :latitude
      t.float      :longitude
      t.string     :email
      t.string     :phone
      t.string     :sport_type
      t.boolean    :is_public
      t.string     :website
      t.boolean    :commercial
      t.references :utility
      t.timestamps null: false
    end
  end
end
