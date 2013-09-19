class AddDistanceToInstructors < ActiveRecord::Migration
  def change
      add_column :users, :max_distance, :integer
  end
end
