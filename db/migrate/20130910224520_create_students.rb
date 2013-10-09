class CreateStudents < ActiveRecord::Migration
    def change
        create_table :students do |t|
            t.integer :profile_id
            t.integer :resource_type
            t.integer :resource_id
            t.boolean :signed_waiver
            
            t.timestamps
        end
            
        add_index :students, :profile_id
        add_index :students, [:profile_id, :resource_type, :resource_id], unique: true
    end
end
