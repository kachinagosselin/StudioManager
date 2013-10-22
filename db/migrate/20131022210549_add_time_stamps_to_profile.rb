class AddTimeStampsToProfile < ActiveRecord::Migration
    change_table :profiles do |t|
        t.timestamps
    end
end
