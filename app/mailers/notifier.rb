class Notifier < ActionMailer::Base
  default from: "notifications@wuwei.com"

	def weekly_notification(user)
		@user = user
		mail(to: @user.email, subject: 'Testing Delay')
	end
end
