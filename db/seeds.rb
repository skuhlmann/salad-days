require 'faker'

class Seed
  def initialize
    generate_users
    generate_markets
    generate_listings
  end

  def generate_users
    20.times do |i|
      user = User.create!(
        name: Faker::Name.name,
        uid: Faker::Code.ean,
        provider: "Twitter",
       )
    end
    puts "users generated"
  end

  def generate_markets
    Market.create!(
      name: Faker::Company.name,
      email: Faker::Internet.email,
      products: Faker::Lorem.sentence(1),
      zip: "80205",
      street: "98 S Broadway",
      city: "Denver",
      state: "CO",
      user_id: 20,
      image: File.new("#{Rails.root}/app/assets/images/market-1.jpeg")
      )

    Market.create!(
      name: Faker::Company.name,
      email: Faker::Internet.email,
      products: Faker::Lorem.sentence(2),
      zip: "80210",
      street: "2041 S University Blvd",
      city: "Denver",
      state: "CO",
      user_id: 19,
      image: File.new("#{Rails.root}/app/assets/images/market-2.jpeg")
      )

    Market.create!(
      name: Faker::Company.name,
      email: Faker::Internet.email,
      products: Faker::Lorem.sentence(2),
      zip: "80207",
      street: "3200 Colorado Blvd",
      city: "Denver",
      state: "CO",
      user_id: 18,
      image: File.new("#{Rails.root}/app/assets/images/market-3.jpeg")
      )

    Market.create!(
      name: Faker::Company.name,
      email: Faker::Internet.email,
      products: Faker::Lorem.sentence(2),
      zip: "80211",
      street: "4408 Lowell Blvd",
      city: "Denver",
      state: "CO",
      user_id: 17,
      image: File.new("#{Rails.root}/app/assets/images/market-5.jpeg")
      )

    Market.create!(
      name: Faker::Company.name,
      email: Faker::Internet.email,
      products: Faker::Lorem.sentence(2),
      zip: "80231",
      street: "333 S Tamarac Dr",
      city: "Denver",
      state: "CO",
      user_id: 16,
      image: File.new("#{Rails.root}/app/assets/images/market-6.jpeg")
      )

    puts "markets generated"
  end

  def generate_listings
    Listing.create!(
      name: "Carrots",
      description: Faker::Lorem.sentence(1),
      harvest_date: Date.current,
      market_id: 1,
      image: File.new("#{Rails.root}/app/assets/images/carrots.jpeg")
      )

    Listing.create!(
      name: "Eggs",
      description: Faker::Lorem.sentence(1),
      harvest_date: Date.current,
      market_id: 2,
      image: File.new("#{Rails.root}/app/assets/images/eggs.jpeg")
      )

    Listing.create!(
      name: "Onions",
      description: Faker::Lorem.sentence(1),
      harvest_date: Date.current,
      market_id: 3,
      image: File.new("#{Rails.root}/app/assets/images/onions.jpeg")
      )

    Listing.create!(
      name: "Pumkpins",
      description: Faker::Lorem.sentence(1),
      harvest_date: Date.current,
      market_id: 4,
      image: File.new("#{Rails.root}/app/assets/images/pumpkin.jpeg")
      )

    Listing.create!(
      name: "Heirloom Tomatoes",
      description: Faker::Lorem.sentence(1),
      harvest_date: Date.current,
      market_id: 5,
      image: File.new("#{Rails.root}/app/assets/images/tomatoes.jpeg")
      )
  end
  puts "Listings generated"
end

Seed.new
