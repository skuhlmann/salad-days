require "rails_helper"

describe "Market owner", type: :feature do

  before(:each) do
    log_in
  end

  it "market owner can create thier market" do
    click_link("Create a Market")
    fill_in("market_name", with: "Trevor's Yard")
    fill_in("market_email", with: "trev@example.com")
    fill_in("market_street", with: "123 main")
    fill_in("market_city", with: "Denver")
    fill_in("market_state", with: "CO")
    fill_in("market_zip", with: "80202")
    click_button("Create Market")

    expect(current_path).to eq("/markets/trevor-s-yard")
    expect(page).to have_text("Trevor's Yard")
    expect(page).to have_text("80202")
  end

  it "can see thier existing market options from thier profile page" do
    user = User.last
    market = create(:market, user: user)

    visit user_path(user)

    expect(page).to have_text("The Market")
    expect(page).to have_text("email@example.com")
  end

  it "can see view listing for thier market" do
    user = User.last
    market = create(:market, user: user)
    listing = create(:listing, market: market)

    visit user_path(user)

    expect(page).to have_text("Current Listings")
    expect(page).to have_text("A Listing")
    expect(page).to have_text("Listing details")
    expect(page).to have_text(listing.harvest_date)
  end

  it "can can edit thier market" do
    user = User.last
    market = create(:market, user: user)

    visit user_path(user)
    click_link_or_button("Edit your market")
    fill_in("market_name", with: "Race Street Farms")
    click_button("Update Market")

    expect(page).to have_text("Market details updated")
    expect(page).to have_text("Race Street Farms")
  end
end


