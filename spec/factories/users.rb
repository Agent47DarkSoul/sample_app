FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password "foobarawesome"
    password_confirmation "foobarawesome"

    trait :with_password do
      password_confirmation { password }
    end
  end
end