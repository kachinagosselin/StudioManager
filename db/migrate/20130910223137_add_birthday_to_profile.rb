class AddBirthdayToProfile < ActiveRecord::Migration
  def change
      add_column :profiles, :dob, :datetime
  end
end
