FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    uid "392993516"
    provider "twitter"

  end
end
