class AddStripeCodeToUser < ActiveRecord::Migration
  def change
      add_column :users, :stripe_code, :string
  end
end
