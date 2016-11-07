class AddFirstnameLastnameAndNewsletterToUsers < ActiveRecord::Migration
  def change
    add_column :users,  :firstname, :string
    add_column :users,  :lastname, :string
    add_column :users,  :newsletter, :boolean, default: false
  end
end
