class AssignCustomerToProfile < ActiveRecord::Migration
  def change
  	remove_column :customers, :studio_id
  	remove_column :customers, :user_id

  	add_column :customers, :profile_id, :integer
  end
end
