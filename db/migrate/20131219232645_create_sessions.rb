class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :profile_id
      t.integer :resource_id
      t.string :resource_type
      t.datetime :start_at
      t.datetime :end_at
      t.text :note
      t.boolean :canceled
      t.boolean :reschedule
      t.boolean :no_show

      t.timestamps
    end
  end
end
