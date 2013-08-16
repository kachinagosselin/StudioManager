class Charge < ActiveRecord::Migration
    def change
        create_table :charges do |t|
            t.integer :studio_id
            t.integer :user_id
            t.string :stripe_card_token
            t.integer :amount
            t.string :description
            t.string :email
            
            t.timestamps
        end
    end
end
