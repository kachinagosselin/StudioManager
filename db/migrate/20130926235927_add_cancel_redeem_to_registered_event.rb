class AddCancelRedeemToRegisteredEvent < ActiveRecord::Migration
  def change
      add_column :registered_events, :canceled_by_student, :boolean, :default => false
      add_column :registered_events, :redeemed, :boolean, :default => false
      add_column :registered_events, :payment_method, :string
  end
end
