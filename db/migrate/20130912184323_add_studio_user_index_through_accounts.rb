class AddStudioUserIndexThroughAccounts < ActiveRecord::Migration
        def change
            add_column :accounts, :studio_id, :integer
            
            add_index :accounts, :user_id
            add_index :accounts, :studio_id
            add_index :accounts, [:user_id, :studio_id], unique: true
        end
    end
