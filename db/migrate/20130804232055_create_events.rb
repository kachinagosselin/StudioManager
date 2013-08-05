class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :instructor
      t.text :description
      t.string :title

      t.timestamps
    end
  end
end
