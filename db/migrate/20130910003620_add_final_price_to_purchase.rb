class AddFinalPriceToPurchase < ActiveRecord::Migration
  def change
      add_column :purchases, :final_price, :integer
      add_column :purchases, :discount_applied, :boolean
  end
end
