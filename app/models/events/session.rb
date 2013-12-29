class Session < Event
	has_one :user

def self.inherited(child)
  child.instance_eval do
    def model_name
      Event.model_name
    end
  end
  super
end
end
