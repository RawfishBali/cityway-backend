class AddExternalLinkToCulinaries < ActiveRecord::Migration
  def change
    add_column :culinaries, :external_link, :string
  end
end
