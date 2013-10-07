class AddCertificationToProfiles < ActiveRecord::Migration
  def change
      add_column :profiles, :certification, :string
      add_column :profiles, :is_not_available, :boolean, :default => false
  end
end
