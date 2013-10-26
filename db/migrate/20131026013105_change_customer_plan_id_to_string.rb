class ChangeCustomerPlanIdToString < ActiveRecord::Migration
  def change
  	change_column :customers, :plan_id, :string
  end
end
