require "rails_helper"

describe "Flagging flow", type: :feature do

  it "can flag a market if signed in" do
    VCR.use_cassette("geocode_1") do
      market = create(:market, user_id: 1)
      market.save

      log_in
      visit market_path(market.slug)
      click_button("Flag It")

      expect(page).to have_text("You've flagged The Market")
      expect(page).to have_button("Unflag It")
    end
  end

  it "can't flag a market if not signed in" do
    VCR.use_cassette("geocode_1") do
      market = create(:market, user_id: 1)
      market.save

      visit market_path(market.slug)

      expect(page).to have_text("The Market")
      expect(page).not_to have_text("Flag It")
    end
  end

  it "can see all listings for the markets she follows" do
    VCR.use_cassette("geocode_1") do
      market = create(:market, user_id: 1)
      listing = create(:listing, market_id: market.id)
      market.save
      listing.save

      log_in
      user = User.last

      visit market_path(market.slug)
      click_button("Flag It")
      visit user_path(user)

      expect(page).to have_text("Flagged market activity")
      expect(page).to have_text("A Listing")
      expect(page).to have_text("The Market")
      expect(page).to have_link("View more detail")
    end
  end

  it "can unflag a market" do
    VCR.use_cassette("geocode_1") do
      market = create(:market, user_id: 1)
      listing = create(:listing, market_id: market.id)
      market.save
      listing.save

      log_in
      user = User.last

      visit market_path(market.slug)
      click_button("Flag It")
      visit user_path(user)
      click_button("Unflag It")

      expect(page).to have_text("You've unflagged The Market")
      expect(page).not_to have_text("Flagged market activity")
    end
  end
end

