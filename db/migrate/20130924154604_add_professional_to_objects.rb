class AddProfessionalToObjects < ActiveRecord::Migration
  def change
      add_column :customers, :professional_id, :integer
      add_column :events, :professional_id, :integer
      add_column :memberships, :professional_id, :integer
      add_column :packages, :professional_id, :integer
      add_column :coupons, :professional_id, :integer
  end
end
