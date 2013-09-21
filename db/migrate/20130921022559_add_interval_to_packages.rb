class AddIntervalToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :interval, :string
    add_column :packages, :interval_count, :integer
  end
end
