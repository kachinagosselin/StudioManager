class CreateStudios < ActiveRecord::Migration
  def change
    create_table :studios do |t|
      t.string :name
      t.string :location
      t.integer :main_phone
      t.string :website

      t.timestamps
    end
  end
end
