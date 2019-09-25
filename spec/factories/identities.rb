# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identity do
    uid "MyString"
    provider "MyString"
    access_token "MyString"
    user nil
  end
end
