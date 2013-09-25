class AddDistanceToInstructors < ActiveRecord::Migration
  def change
      add_column :profiles, :max_distance, :integer
  end
end
