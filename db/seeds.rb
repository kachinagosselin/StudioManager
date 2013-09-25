# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'CREATING ROLES'
Role.create([
            { :name => 'admin' }, 
            { :name => 'owner' }, 
            { :name => 'instructor' }
            ], :without_protection => true)

puts 'CREATING PLANS'
Plan.create!(:name => "StudioManager Account", :price => 30)

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'Kachina Gosselin', :email => 'kachina@alum.mit.edu', :password => 'password', :password_confirmation => 'password'
user.add_role :owner
user.save

user2 = User.create! :name => 'Test Account', :email => 'kachina.gosselin@gmail.com', :password => 'password', :password_confirmation => 'password'

puts 'SETTING UP DEFAULT ACCOUNT'
account = Account.create! :plan_id => "studio-basic", :user_id => 1, :stripe_customer_token => "cus_2LhxTeT79mll1r", :email => "kachina@alum.mit.edu", :is_active => true
account2 = Account.create! :plan_id => "professional-basic", :user_id => 2, :stripe_customer_token => "cus_2LhxTeT79mll1r", :email => "kachina.gosselin@gmail.com", :is_active => true

puts 'SETTING UP DEFAULT STUDIO'
studio = Studio.create! :name => "Test Studio", :location => "29 Rausch Street San Francisco CA 94103", :address => "29 Rausch Street", :city => "San Francisco", :state => "CA", :account_id => account.id
studio2 = Studio.create! :name => "Test Studio2", :location => "20 Rausch Street San Francisco CA 94103", :address => "20 Rausch Street", :city => "San Francisco", :state => "CA", :account_id => account.id

puts 'SETTING UP DEFAULT CUSTOMER'
customer = Customer.create!(:id => 1, :user_id => 1, :studio_id => 1, :stripe_customer_token => "cus_2LhxTeT79mll1r", :last_4_digits => "4444", :plan_id => 1, :quantity => 1)


puts 'SETTING UP DEFAULT EVENTS'
event11 = Event.create!(:start_at => DateTime.now, :studio_id => 1, :end_at => Date.today+1, :instructor => user.name, :archive => false, :price => 10, :description => "First event of studio 1", :title => "Studio 1 Event 1")
event12 = Event.create!(:start_at => Date.today+2, :studio_id => 1, :end_at => Date.today+3, :instructor => user.name, :archive => false, :price => 10, :description => "Second event of studio 1", :title => "Studio 1 Event 2")
event21 = Event.create!(:start_at => Date.today+3, :studio_id => 2, :end_at => Date.today+4, :instructor => user.name, :archive => false, :price => 10, :description => "First event of studio 2", :title => "Studio 2 Event 1")