class AddLocationStringToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :address, :string
  	add_column :events, :city, :string
  	add_column :events, :state, :string
  end
end
