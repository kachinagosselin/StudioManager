class AddMapToStudios < ActiveRecord::Migration
  def change
    add_column :studios, :latitude, :float
    add_column :studios, :longitude, :float
    add_column :studios, :gmaps, :boolean
    add_column :studios, :address, :string
    add_column :studios, :city, :string
    add_column :studios, :state, :string
  end
end
