class FixResourceTypeStudent < ActiveRecord::Migration
  def change
  	remove_column :students, :resource_type
  	add_column :students, :resource_type, :string
  end
end
