class AddTimeStampsToProfile < ActiveRecord::Migration
    change_table :profiles do |t|
        t.timestamps, :null => false, :default => Time.now
    end
end
