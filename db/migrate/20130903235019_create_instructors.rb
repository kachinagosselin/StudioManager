class CreateInstructors < ActiveRecord::Migration
    def change
        create_table :instructors do |t|
            t.integer :user_id
            t.integer :studio_id
            
            t.timestamps
        end
        
        add_index :instructors, :user_id
        add_index :instructors, :studio_id
        add_index :instructors, [:user_id, :studio_id], unique: true
    end
end
