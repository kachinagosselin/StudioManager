class Subscription < ActiveRecord::Migration
    def change
        create_table :subscriptions do |t|
            t.integer :studio_id
            t.integer :user_id
            t.string :status
            t.string :stripe_customer_token
            t.boolean :cancel_at_period_end
            t.integer :plan_id
            t.integer :quantity
            t.datetime :started_at
            t.datetime :canceled_at
            t.datetime :current_period_end
            t.datetime :current_period_start
            t.datetime :ended_at
            t.datetime :trial_end_at
            t.datetime :trial_start_at
            
            t.timestamps
        end
    end
end
