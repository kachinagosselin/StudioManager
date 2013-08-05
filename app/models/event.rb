class Event < ActiveRecord::Base
    attr_accessible :description, :end_time, :instructor, :start_time, :title
end
