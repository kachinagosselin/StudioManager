class CreateStudios < ActiveRecord::Migration
  def change
    create_table :studios do |t|
      t.string :name
      t.integer :main_phone, :limit => 8
      t.string :website

      t.timestamps
    end
  end
end
