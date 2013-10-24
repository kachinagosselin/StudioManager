class AddDefaultCanceledToEvents < ActiveRecord::Migration
  def change
    change_column :events, :canceled, :boolean, :default => false
  end
end
