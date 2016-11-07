class AddExternalLinkToStories < ActiveRecord::Migration
  def change
    add_column :stories, :external_link, :string
  end
end
