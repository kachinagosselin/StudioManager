class AddAccessTokenToCustomer < ActiveRecord::Migration
  def change
      add_column :customers, :access_token, :string
      add_column :customers, :refresh_token, :string
      add_column :customers, :stripe_publishable_key, :string
      add_column :customers, :stripe_user_id, :string
  end
end
