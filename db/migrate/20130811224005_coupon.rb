class Coupon < ActiveRecord::Migration
    def change
        create_table :coupons do |t|
            t.string :studio_id
            t.integer :user_id
            t.string :duration
            t.integer :amount_off
            t.integer :duration_in_months
            t.integer :max_redemptions
            t.integer :percent_off
            t.datetime :redeem_by
            
            t.timestamps
        end
    end
end
