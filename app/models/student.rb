class Student < ActiveRecord::Base
  attr_accessible :event_id, :student_id
            belongs_to :event, class_name: "Event"
        belongs_to :student, class_name: "Student"
    validates :event_id, presence: true
    validates :student_id, presence: true
end
