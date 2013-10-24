class Studio < ActiveRecord::Base
    resourcify
    
    acts_as_gmappable :check_process => false
    geocoded_by :gmaps4rails_address   
    after_validation :geocode          # auto-fetch coordinates
    
    belongs_to :user
    belongs_to :account
    
    has_many :locations
    has_many :purchases
    has_many :registered_events
    
    after_create :instantiate_first_location


    attr_accessible :address, :city, :state
    attr_accessible :location, :main_phone, :name, :website, :account_id, :cancellation_policy, :student_waiver, :instructor_waiver, :default_event_price, :description
    
    def instantiate_first_location
        self.locations.create!(:address => address, :city => city, :state => state)
    end
    
    def gmaps4rails_address
        "#{self.address} #{self.city}, #{self.state}" 
    end
    
    def add_student(user, signed)
        if signed == true
            # create Student object with resource type and resource id
        end
    end
    
    def staff
        Profile.with_role(:instructor, self).uniq
    end
    
    def save_customer!(client, options = {})
        if user.customer.present?
            stripe_customer = Stripe::Customer.create({description: user.email, card: user.customer.stripe_card_token, email: user.email}, client.customer.access_token)
            else
            stripe_customer = Stripe::Customer.create({description: user.email, card: stripe_card_token, email: user.email}, client.customer.access_token)
            if  !user.customer.present?
                customer = user.create_customer(:stripe_customer_token => stripe_customer.id, :email => user.email, :last_4_digits => last_4_digits)
            end
        end
        
      user.profile.become_student!(self)
   end
    
    
   def events 
       Event.where(:resource_type => "Studio").where(:resource_id => self.id)
   end

    def coupons 
        Coupon.where(:resource_type => "Studio").where(:resource_id => self.id)
    end
    
    def memberships 
        Membership.where(:resource_type => "Studio").where(:resource_id => self.id)
    end
    
    def packages 
        Package.where(:resource_type => "Studio").where(:resource_id => self.id)
    end
    
    def students 
        Profile.joins(:students).where(["students.resource_id = ? AND students.resource_type = ?", self.id, "Studio"])
    end
    
    # This creates the html for the Studio display on the student dashboard
    def html
        html = "<div class='row'>
        <div class='col-lg-6' style='padding-right:30px;'>
        <h3>#{self.name} </h3>"
        @locations = self.locations
        if @locations.count == 1
            html = html +
            "<p> Address: #{self.address} #{self.city}, #{self.state} </p>"
        elsif @locations.count > 1 
            html = html + "<p> Located at the following addresses: </p>" 
            @locations.each do |loc|
            html = html + 
            "<p> #{loc.address} #{loc.city}, #{loc.state} </p>"
            end
        end
        
        if self.main_phone.present?
            html = html +
            "<p> Phone: #{self.main_phone} </p>"
        end

        if self.website.present?
            html = html +
            "<p> Website: <a>#{self.website}</a></p>"
        end
        
        if false
            html = html + 
            "<p> #{self.description} </p>"
        end
        
        html = html +
        "</div>
        
        <div class='col-lg-5' style='margin-top:25px;'>
        <div class='panel panel-primary' >
        <div class='panel-heading'>
        <h5 class='panel-title'>Studio Offerings </h5>
        </div>
        
        <ul class='list-group' style='list-style-type:none;'>"
        
        self.memberships.each do |membership|
            name = membership.name
            id = membership.id
            html = html + "
            <li class='list-group-item'>#{name} <a href='/memberships/#{id}/purchase/1' style='margin-top:-5px;' class='btn btn-primary btn-sm pull-right'>
            Purchase</a></li>"

            # Add a purchase button
        end
        
        html = html + "</ul></div></div></div>"
        return html
    end

    def embed_script
        "<script src='" + Rails.application.routes.url_helpers.studio_url(self) + ".js'" + "></script>"
    end
end
