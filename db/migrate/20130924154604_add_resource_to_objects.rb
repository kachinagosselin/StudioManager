class AddResourceToObjects < ActiveRecord::Migration
  def change
      add_column :events, :resource_id, :integer
      add_column :memberships, :resource_id, :integer
      add_column :packages, :resource_id, :integer
      add_column :coupons, :resource_id, :integer
      
      add_column :events, :resource_type, :string
      add_column :memberships, :resource_type, :string
      add_column :packages, :resource_type, :string
      add_column :coupons, :resource_type, :string
  end
end
