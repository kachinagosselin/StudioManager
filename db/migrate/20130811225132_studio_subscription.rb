class StudioSubscription < ActiveRecord::Migration
    def change
        create_table :studio_subscriptions do |t|
            t.string :studio_id
            t.integer :user_id
            t.string :status
            t.string :stripe_customer_token
            t.boolean :cancel_at_eriod_end
            t.integer :plan_id
            t.integer :quantity
            t.datetime :start
            t.datetime :cenceled_at
            t.datetime :current_period_end
            t.datetime :current_period_start
            t.datetime :ended_At
            t.datetime :trial_end_at
            t.datetime :trial_start_at
            
            t.timestamps
        end
    end
end
