class Event < ActiveRecord::Base
    has_event_calendar
    belongs_to :studio
    has_one :charge
    
    attr_accessible :studio_id, :description, :end_at, :instructor, :start_at, :title
    
    # need to override the json view to return what full_calendar is expecting.
    # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
    def as_json(options = {})  
        {  
            :id => self.id,  
            :title => self.title,  
            :start => start_at.rfc822,  
            :end => end_at.rfc822,  
            :allDay => self.all_day,  
            :recurring => false,  
            :url => Rails.application.routes.url_helpers.studio_events_path(self.studio_id),  
        }  
    end  
    
    scope :between, lambda {|start_time, end_time|  
    {:conditions => ["? < starts_at < ?", Event.format_date(start_time),      Event.format_date(end_time)] }  
    }  
    def self.format_date(date_time)  
    Time.at(date_time.to_i).to_formatted_s(:db)  
    end

end
