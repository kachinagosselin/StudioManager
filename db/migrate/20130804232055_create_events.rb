class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.integer :instructor_id
      t.text :description
      t.string :title

      t.timestamps
    end
  end
end
