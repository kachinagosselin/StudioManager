# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    start_time "2013-08-04 16:20:55"
    end_time "2013-08-04 16:20:55"
    instructor "MyString"
    description "MyText"
  end
end
