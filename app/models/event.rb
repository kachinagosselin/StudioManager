class Event < ActiveRecord::Base
    has_event_calendar

    attr_accessible :description, :end_at, :instructor, :start_at, :title
end
