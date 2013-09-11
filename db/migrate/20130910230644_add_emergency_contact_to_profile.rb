class AddEmergencyContactToProfile < ActiveRecord::Migration
  def change
      add_column :profiles, :emergency_contact_name, :string
      add_column :profiles, :emergency_contact_number, :integer
  end
end
