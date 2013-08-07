class Plan < ActiveRecord::Migration
    def change
        create_table :plans do |t|
            t.string :name
            t.decimal :price
            t.integer :limit
                
            t.timestamps
        end
    end
end
