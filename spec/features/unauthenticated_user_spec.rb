require "rails_helper"

describe "Unauthenticated user", type: :feature do

  it "can browse market listing by zip code" do
    market = create(:market, user_id: 1)
    listing = create(:listing, market_id: market.id)
    market.save
    listing.save

    visit root_path
    fill_in("zip", with: "80205")
    click_button("Search")

    expect(page).to have_text(market.name)
    expect(page).to have_text(listing.name)
    expect(page).to have_text("Tiri's Garden Farmers")
    expect(page).to have_text("City Park Esplanade Fresh Market")
    expect(page).to have_text("Stapleton Farmers Market")
    expect(page).to have_text("1001 Osage Street, Denver, Colorado, 80204")
    expect(page).to have_text("05/03/2014 to 10/25/2014 Wed: 9:00 AM-1:00 PM;Sat: 8:00 AM-1:00 PM")

    click_link("View Market Details")
    expect(current_path).to eq(market_path(market.slug))
    expect(page).to have_text(market.name)
  end

  it "is promted to search another zip code when no results are found" do
    market = create(:market, user_id: 1)
    listing = create(:listing, market_id: market.id)
    market.save
    listing.save

    visit root_path
    fill_in("zip", with: "99762")
    click_button("Search")

    expect(page).to have_text("No results found for the zipcode: 99762. Please try another zip code.")
  end

  it "is prompted to enter a zip on the search page" do
    visit search_results_path

    expect(page).to have_text("Enter a zipcode to find markets in your area")
  end

  it "can narrow the listings on the markets page by zip code" do
    market = create(:market, user_id: 1)
    listing = create(:listing, market_id: market.id)
    another_market = Market.create(name: "Another Market", email: "two@example.com", street: "6000 Vine", city: "LA", state: "CA", zip: "90028", user_id: 2)
    another_listing = create(:listing, market_id: another_market.id)
    market.save
    another_market.save
    listing.save
    another_listing.save

    visit search_results_path
    fill_in("zip", with: "80205")
    click_button("Search")

    expect(page).to have_text("The Market")
    expect(page).not_to have_text("Another Market")

  end

  it "can visit a market detail page" do
    market = create(:market, user_id: 1)
    listing = create(:listing, market_id: market.id)

    visit market_path(market.slug)

    expect(page).to have_text(market.full_address)
    expect(page).to have_text(listing.name)
    expect(page).to have_text(listing.harvest_date)
  end

  it "can't visit a market that doesn't exist" do
    visit root_path

    visit("/markets/fake-market")
    expect(current_path).to eq(root_path)
    expect(page).to have_text("Market doesn't exist")
  end
end


