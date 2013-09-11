class CreateStudents < ActiveRecord::Migration
    def change
        create_table :students do |t|
            t.integer :user_id
            t.integer :studio_id
            t.boolean :signed_waiver
            
            t.timestamps
        end
            
        add_index :students, :user_id
        add_index :students, :studio_id
        add_index :students, [:user_id, :studio_id], unique: true
    end
end
