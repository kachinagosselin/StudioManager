# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
    price 1
    name "MyString"
    start_at "2013-11-06 19:27:15"
    duration 1
    resource_type "MyString"
    resource_id 1
  end
end
