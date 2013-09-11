class AddPoliciesToStudio < ActiveRecord::Migration
  def change
      add_column :studios, :student_waiver, :text
      add_column :studios, :instructor_waiver, :text
      add_column :studios, :cancellation_policy, :text
  end
end
