class CreateRegisteredEvent < ActiveRecord::Migration
        def change
            create_table :registered_events do |t|
                t.integer :user_id
                t.integer :event_id
                t.integer :studio_id
                t.boolean :attended, :default => false
                t.boolean :canceled, :default => true
                
                t.timestamps
            end
            add_index :registered_events, :user_id
            add_index :registered_events, :event_id
            add_index :registered_events, :studio_id
            add_index :registered_events, [:user_id, :event_id, :studio_id], unique: true, :name => 'student_events'
        end

end
