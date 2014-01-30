class Student < ActiveRecord::Base
	attr_accessible :profile_id, :resource_type, :resource_id, :signed_waiver

	belongs_to :studio
	belongs_to :user
	belongs_to :profile
	validates :profile_id, uniqueness: { scope: [:resource_type, :resource_id], message: "already a student" }
	validates :resource_type, :resource_id, presence: true

	def profile
		Profile.find(self.profile_id)
	end


	def frequency(array)
		count = array.count 
		first = array.first 
		last = array.last
		sec_in_week = 3600*24*7
		range = (last.start_at-first.start_at)/sec_in_week
		if range > 1
			freq_per_month = ((count/range)*2).to_int
			string = "#{freq_per_month} per month"
		elsif range <= 1
			freq_per_week = count/range
			string = "#{freq_per_week} per week"
		end

		return string
	end

	# Get student's last paid session

	# Get student's next scheduled session

	# Return string notifying approx date of next visit
	def next_notification
	return "next visit 12/14"
	end
end
