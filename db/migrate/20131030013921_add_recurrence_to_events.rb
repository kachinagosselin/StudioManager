class AddRecurrenceToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :start_on, :datetime
  	add_column :events, :every, :string
  	add_column :events, :end_on, :datetime
  end
end
