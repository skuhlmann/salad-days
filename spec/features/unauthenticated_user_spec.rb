require "rails_helper"

describe "Unauthenticated user", type: :feature do

  xit "can browse market listing by zip code" do
    market = create(:market, user_id: 1)
    listing = create(:listing, market_id: market.id)

    visit root_path
    fill_in("zip_code", with: "80205")
    click_button("Search")

    expect(page).to have_text(market.name)
    expect(page).to have_text(listing.name)

    click_link("View Market Details")
    expect(current_path).to eq(market_path(market.slug))
    expect(page).to have_text(market.name)
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


