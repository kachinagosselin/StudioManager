class Availability < ActiveRecord::Base
    belongs_to :profile
  attr_accessible :day_of_week, :end_at, :start_at
    
    def week_day
        day_of_week = self.day_of_week
        if day_of_week == 0
            return "Sun"
            elsif day_of_week == 1
            return "Mon"
            elsif day_of_week == 2
            return "Tues"
            elsif day_of_week == 3
            return "Wed"
            elsif day_of_week == 4
            return "Thurs"
            elsif day_of_week == 5
            return "Fri"
            elsif day_of_week == 6
            return "Sat"
        end
    end
end
