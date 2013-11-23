# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :micropost do
    user
    content { Faker::Lorem.sentence }
  end
end
