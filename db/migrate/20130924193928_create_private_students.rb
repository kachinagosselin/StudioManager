class CreatePrivateStudents < ActiveRecord::Migration
    def change
        create_table :private_students do |t|
            t.integer :user_id
            t.integer :professional_id
            t.boolean :signed_waiver
            
            t.timestamps
        end
        
        add_index :private_students, :user_id
        add_index :private_students, :professional_id
        add_index :private_students, [:user_id, :professional_id], unique: true
    end
end
