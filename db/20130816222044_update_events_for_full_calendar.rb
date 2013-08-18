class UpdateEventsForFullCalendar < ActiveRecord::Migration
        def change
            add_column :events, :allDay, :boolean
            add_column :events, :url, :float
            add_column :events, :className, :string
            add_column :events, :editable, :boolean
            add_column :events, :startEditable, :boolean
            add_column :events, :source, :string
            rename_column :events, :start_at, :start
            rename_column :events, :end_at, :end
        end
end
