class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :student_id
      t.integer :event_id

      t.timestamps
    end
      add_index :students, :event_id
      add_index :students, :student_id
      add_index :students, [:event_id, :student_id], unique: true
  end
end
