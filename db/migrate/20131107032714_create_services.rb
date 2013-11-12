class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.integer :price
      t.string :name
      t.datetime :start_at
      t.integer :duration
      t.string :resource_type
      t.integer :resource_id

      t.timestamps
    end
  end
end
