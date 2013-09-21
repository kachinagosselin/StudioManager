class CreateCreditsForUser < ActiveRecord::Migration
    def change
        create_table :credits do |t|
            t.integer :studio_id
            t.integer :customer_id
            t.integer :quantity
            t.datetime :expires_at
            
            t.timestamps
        end
        add_index :credits, :customer_id
    end
end
