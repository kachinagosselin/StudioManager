class Customer < ActiveRecord::Migration
    def change
        create_table :customers do |t|
            t.string :studio_id
            t.integer :user_id
            t.string :stripe_customer_token
            t.string :last_4_digits
            t.integer :plan_id
            t.integer :quantity
            t.datetime :trial_end_at
            t.string :email
            t.string :coupon_code
            t.string :description
            
            t.timestamps
        end
    end
end
