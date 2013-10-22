class AddWaiverToProfessional < ActiveRecord::Migration
  def change
  	add_column :profiles, :student_waiver, :text
  end
end
