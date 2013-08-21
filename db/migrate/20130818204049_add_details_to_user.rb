class AddDetailsToUser < ActiveRecord::Migration
  def change
      add_column :users, :phone, :integer
      add_column :users, :address, :string
      add_column :users, :city, :string
      add_column :users, :state, :string
      add_column :users, :description, :text
      add_column :users, :is_certified, :boolean
      add_column :users, :is_available, :boolean
  end
end
