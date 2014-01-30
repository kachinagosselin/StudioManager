class AddPrivatePublicBooleansToStudents < ActiveRecord::Migration
  def change
  	add_column :students, :public, :boolean, :default => false
  	add_column :students, :private, :boolean, :default => false
  end
end
