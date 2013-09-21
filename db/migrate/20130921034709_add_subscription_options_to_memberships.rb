class AddSubscriptionOptionsToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :one_time_app, :boolean, :default => false
    add_column :memberships, :prorate, :boolean, :default => false
  end
end
