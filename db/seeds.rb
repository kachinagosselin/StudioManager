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
            { :name => 'instructor' }, 
            { :name => 'student' }
            ], :without_protection => true)

puts 'CREATING PLANS'
Plan.create!(:name => "StudioManager Account", :price => 30)

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'Kachina Gosselin', :email => 'kachina@alum.mit.edu', :password => 'password', :password_confirmation => 'password'
user.add_role :admin
user.save

puts 'Setting UP DEFAULT EVENTS'
