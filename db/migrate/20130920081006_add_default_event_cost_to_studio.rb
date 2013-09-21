class AddDefaultEventCostToStudio < ActiveRecord::Migration
  def change
    add_column :studios, :default_event_price, :integer
  end
end
