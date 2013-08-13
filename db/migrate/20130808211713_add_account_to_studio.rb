class AddAccountToStudio < ActiveRecord::Migration
  def change
      add_column :studios, :account_id, :integer
  end
end
