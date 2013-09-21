class AddTitleToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :title, :string
  end
end
