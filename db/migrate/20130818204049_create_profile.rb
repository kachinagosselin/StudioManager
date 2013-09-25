class CreateProfile < ActiveRecord::Migration
  def change
      create_table :profiles do |t|
          t.integer :phone, :limit => 8
          t.string :address
          t.string :city
          t.string :state
          t.text :description
          t.boolean :is_certified
          t.boolean :is_available
          t.boolean :hide_map
          t.integer :user_id
      end
  end
end
