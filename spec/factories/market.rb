FactoryGirl.define do
  factory :market do
    name "The Market"
    email "email@example.com"
    street "123 Main"
    city "Denver"
    state "CO"
    zip "80205"
  end

  factory :listing do
    name "A Listing"
    description "Listing details"
    harvest_date Date.current
  end

end
