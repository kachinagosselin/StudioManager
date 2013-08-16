class Membership < ActiveRecord::Migration
    def change
        create_table :memberships do |t|
            t.integer :studio_id
            t.string :name
            t.integer :price
            t.string :interval
            t.integer :interval_count
            t.integer :trial_period_days
            
            t.timestamps
        end
    end
end
