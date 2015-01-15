FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    uid "abc123"
    provider "twitter"
    location "Denver"
  end
end
