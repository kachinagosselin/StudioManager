class CreateRegisteredEvent < ActiveRecord::Migration
        def change
            create_table :registered_events do |t|
                t.integer :profile_id
                t.integer :event_id
                t.integer :studio_id
                t.boolean :attended, :default => false
                
                t.timestamps
            end
            add_index :registered_events, :profile_id
            add_index :registered_events, :event_id
            add_index :registered_events, :studio_id
            add_index :registered_events, [:profile_id, :event_id, :studio_id], unique: true, :name => 'student_events'
        end

end
