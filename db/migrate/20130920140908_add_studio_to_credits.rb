class AddStudioToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :studio_id, :integer
  end
end
