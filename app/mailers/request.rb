class Request < ActionMailer::Base
  default :to "kachina@alum.mit.edu"

	def request(name, email)
		mail(from: email, subject: '#{Name} has requested access to your beta site')
	end
end
