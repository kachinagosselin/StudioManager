class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :studio_id

      t.timestamps
    end
      add_index :locations, :studio_id
  end
end
