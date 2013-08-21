class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :customer_id
      t.integer :product_id
        t.string :product_type

      t.timestamps
    end
      add_index :purchases, :customer_id
      add_index :purchases, :product_id
      add_index :purchases, [:customer_id, :product_id], unique: true
  end
end
