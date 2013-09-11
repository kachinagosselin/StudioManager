class CreatePhotos < ActiveRecord::Migration
    def change
        create_table :photos do |t|
            t.string :name
            t.attachment :image
            t.references :imageable, polymorphic: true
            t.timestamps
            
        end
    end
end
