class AddActiveRoleToUser < ActiveRecord::Migration
  def change
      add_column :users, :active_role_id, :integer
  end
end
