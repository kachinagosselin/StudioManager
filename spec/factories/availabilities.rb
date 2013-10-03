# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :availability do
    start_at "2013-10-02 13:22:26"
    end_at "2013-10-02 13:22:26"
    day_of_week "MyString"
  end
end
