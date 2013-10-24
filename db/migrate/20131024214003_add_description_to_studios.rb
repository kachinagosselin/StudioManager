class AddDescriptionToStudios < ActiveRecord::Migration
  def change
  	add_column :studios, :description, :text
  end
end
