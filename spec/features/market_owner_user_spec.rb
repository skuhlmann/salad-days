require "rails_helper"

describe "Market owner", type: :feature do

  before(:each) do
    log_in
  end

  it "market owner can create their market" do
    user = User.last
    VCR.use_cassette("geocode_3") do
      click_link("Create a Market")
      fill_in("market_name", with: "Trevor's Yard")
      fill_in("market_email", with: "trev@example.com")
      fill_in("market_street", with: "123 main")
      fill_in("market_city", with: "Denver")
      fill_in("market_state", with: "CO")
      fill_in("market_zip", with: "80202")
      click_button("Create Market")

      expect(current_path).to eq(user_path(user))
      expect(page).to have_text("Trevor's Yard")
      expect(page).to have_text("80202")
    end
  end

  it "can see their existing market options from their profile page" do
    user = User.last
    market = create(:market, user: user)

    visit user_path(user)

    expect(page).to have_text("The Market")
    expect(page).to have_text("email@example.com")
  end

  it "can see view listing for their market" do
    user = User.last
    market = create(:market, user: user)
    listing = create(:listing, market: market)

    visit user_path(user)

    expect(page).to have_text("Your Listings")
    expect(page).to have_text("A Listing")
    expect(page).to have_text("Listing details")
    expect(page).to have_text(listing.harvest_date)
  end

  it "can can edit their market" do
    VCR.use_cassette("geocode_1") do
      user = User.last
      market = create(:market, user: user)

      VCR.use_cassette("geocode_4") do
        visit user_path(user)
        click_link_or_button("Edit your market")
        fill_in("market_name", with: "Race Street Farms")
        click_button("Update Market")

        expect(page).to have_text("Market details updated")
        expect(page).to have_text("Race Street Farms")
      end
    end
  end

  it "can add a new listing for thier market" do
    user = User.last
    market = create(:market, user: user)

    visit user_path(user)
    click_link_or_button("Add a Listing")
    fill_in("listing_name", with: "Turnip")
    fill_in("listing_description", with: "A description")
    select("2015", from: "listing_harvest_date_1i")
    select("January", from: "listing_harvest_date_2i")
    select("22", from: "listing_harvest_date_3i")
    click_button("Create Listing")

    expect(current_path).to eq(user_path(user))
    expect(page).to have_text("Listing Added")
    expect(page).to have_text("Turnip")
  end

  it "can mark a listing as sold or expired" do
    user = User.last
    market = create(:market, user: user)
    listing = create(:listing, market: market)

    visit user_path(user)
    expect(page).to have_text("A Listing")

    click_link("Sold/Remove")
    expect(page).not_to have_text("A Listing")
  end

  it "can edit and existing listing" do
    user = User.last
    market = create(:market, user: user)
    listing = create(:listing, market: market)

    visit user_path(user)
    click_link_or_button("Edit listing")
    fill_in("listing_name", with: "A new listing name")
    click_button("Update Listing")

    expect(current_path).to eq(user_path(user))
    expect(page).to have_text("Listing Updated")
    expect(page).to have_text("A new listing name")
  end
end


