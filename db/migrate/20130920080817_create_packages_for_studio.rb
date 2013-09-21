class CreatePackagesForStudio < ActiveRecord::Migration
    create_table :packages do |t|
        t.integer :studio_id
        t.integer :quantity
        t.integer :percent_off
        t.string :name
        t.string :title
        t.integer :price
        t.boolean :archived
        t.datetime :expires_at
    
        t.timestamps
    end

    add_index :packages, :studio_id

end
