class AddGmapsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :latitude, :float
    add_column :profiles, :longitude, :float
    add_column :profiles, :gmaps, :boolean
  end
end
