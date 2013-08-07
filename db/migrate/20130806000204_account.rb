class Account < ActiveRecord::Migration
    def change
        create_table :accounts do |t|
            t.integer :plan_id
            t.integer :user_id
            t.string :stripe_customer_token
            t.string :email
            t.boolean :is_active
            
            t.timestamps
        end
    end
end