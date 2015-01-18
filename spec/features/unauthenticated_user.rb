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
  end

  xit "can visit a market detail page" do
    market = create(:market, user_id: 1)
    listing = create(:listing, market_id: market.id)

    visit root_path
    fill_in("zip_code", with: "80205")
    click_button("Search")
    click_link("View Market Detail")

    expect(current_path).to eq(market_path(market.slug))
    expect(page).to have_text(market.name)
    expect(page).to have_text(listing.name)
  end
end


