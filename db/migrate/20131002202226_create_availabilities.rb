class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.time :start_at
      t.time :end_at
      t.integer :day_of_week
      t.integer :profile_id

      t.timestamps
    end
      
      add_index :availabilities, :profile_id
  end
end
