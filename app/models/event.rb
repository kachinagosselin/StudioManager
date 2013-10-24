class Event < ActiveRecord::Base
    resourcify
    belongs_to :studio
    has_one :charge
    has_many :registered_events
    has_many :students, foreign_key: "user_id", :through => :registered_events, :source => :user
    attr_accessible :studio_id, :description, :end_at, :instructor_id, :start_at, :title, :registered_events, :registered_events_attributes, :archive, :price, :resource_type, :resource_id, :custom_url, :canceled
    
    
    
    # need to override the json view to return what full_calendar is expecting.
    # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
    def as_json  
        {  
            :id => self.id,  
            :title => self.title,  
            :start => self.start_at.rfc822,  
            :end => self.end_at.rfc822,  
            :allDay => false,  
            :recurring => false,  
            :url => self.url,  
        }  
    end  
    
    scope :between, lambda {|start_time, end_time|  
    {:conditions => ["? < start_at < ?", start_time, end_time] }  
    }  

    scope :not_canceled, where(:canceled => false).order('events.start_at DESC')
    scope :canceled, where(:canceled => true).order('events.start_at DESC')

    scope :past, not_canceled.where("start_at < ?", Time.now + 15.minutes).order('events.start_at DESC')
    scope :upcoming, not_canceled.where("start_at >= ?", Time.now - 15.minutes).order('events.start_at DESC')
    scope :sorted, order('events.created_at DESC')

    scope :archived, past.joins(canceled)

    scope :next_week, upcoming.where("start_at <= ?", Time.now + 7.days).order('events.start_at DESC')
    scope :next_month, upcoming.where("start_at >= ?", Time.now + 1.month).order('events.start_at DESC')

    scope :last_week, past.where("start_at > ?", Time.now - 7.days).order('events.start_at DESC')
    scope :last_month, past.where("start_at < ?", Time.now - 1.month).order('events.start_at DESC')

    def self.format_date(date_time)  
    Time.at(date_time.to_i).to_formatted_s(:long_ordinal) 
    end

    def day_of_week
        day_of_week = start_at.wday
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

    def date
        self.start_at.strftime("%B %e, %Y")
    end

    def date_condensed
        self.start_at.strftime("%b %e, %Y")
    end

    def start_time 
        self.start_at.strftime("%l:%M %P")
    end

    def end_time 
        self.end_at.strftime("%l:%M %P")
    end

    def duration
        days = ((end_at-start_at) / (24*3600)).round
        hours_remaining = ((end_at-start_at) / 3600).round % 24
        hours = ((end_at-start_at) / 3600).round
        minutes_remaining = ((end_at-start_at)/ 60).round % 60

        string = ""
        if days != 0 && days != 1
            string = string + "#{days} days "
        elsif days == 1
            string = string + "#{days} day "
        end

        if hours != 0 && hours != 1
            string = string + "#{hours} hrs "
        elsif hours == 1
            string = string + "60 mins"
        end

        if minutes_remaining != 0 && minutes_remaining != 1
            string = string + "#{minutes_remaining} mins"
        elsif minutes_remaining == 1
            string = string + "#{minutes_remaining} min"
        end

        return string
    end

    def url
        if self.custom_url.present?
            return self.custom_url
        else
            Rails.application.routes.url_helpers.event_path(self.id)
        end
    end

    # Required to make sure all events have instructor field
    def instructor
        if self.instructor_id.present?
            User.find(self.instructor_id).name
        end
    end

    def resource
        if self.resource_id.present?
            self.resource_type.constantize.find(self.resource_id)
        end
    end

    def location
        if self.resource_type == "Studio"
            return self.resource.location.first.gmaps4rails_address
        else
            return ""
        end
    end

    def cost
        return ""
    end

    def register!(student, studio)
        registered_event.create!(student_id: student.id, studio_id: studio.id)
    end

    def object
        if self.resource_type == "Studio"
            return Studio.find(self.resource_id)
        elsif self.resource_type == "User"
            return User.find(self.resource_id)
        else
            return nil
        end
    end

    def registered
        events = RegisteredEvent.where(:event_id => self.id)
        registered = []
        
        events.each do |e|
            registered << Profile.find(e.profile_id)
        end
        
        return registered
        
    end

    def attendees
        events = RegisteredEvent.where(:event_id => self.id).where(:attended => true )
        attendees = []
        
        events.each do |e|
            attendees << Profile.find(e.profile_id)
        end
        
        return attendees
        
    end

    def attendance_descriptor
        if self.registered.count == 0 
            return "none"
        else
            return "#{event.attendees.count} of #{event.registered.count}"
        end
    end

end
