class AddUserVariablesToProfile < ActiveRecord::Migration
  def change
      add_column :profiles, :name, :string
      add_column :profiles, :email, :string
  end
end
