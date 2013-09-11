class AddArchiveToEvent < ActiveRecord::Migration
  def change
      add_column :events, :archive, :boolean
  end
end
