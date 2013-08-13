class StudioPlan < ActiveRecord::Migration
    def change
        create_table :studio_plans do |t|
            t.integer :studio_id
            t.string :name
            t.integer :amount
            t.string :interval
            t.integer :interval_count
            t.integer :trial_period_days
            
            t.timestamps
        end
    end
end
