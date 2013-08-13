class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|

      t.timestamps
    end
  end
end
