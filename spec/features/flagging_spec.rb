require "rails_helper"

describe "Flagging flow", type: :feature do

  it "can flag a market" do
    market = create(:market, user_id: 1)
    listing = create(:listing, market_id: market.id)
    market.save
    listing.save

    log_in
    visit root_path
    fill_in("zip", with: "80205")
    click_button("Search")
    click_link("View Market Details")
    click_link("Flag It")

    expect(page).to have_text("You've flagged The Market")
    expect(page).to have_text("Unflag It")
  end

  xit "can see all listings for the markets she follows" do
  end

  xit "can unflag a market" do
    market = create(:market, user_id: 1)
    listing = create(:listing, market_id: market.id)
    market.save
    listing.save

    log_in
    visit market_path(market.slug)
    click_link("Flag It")
    click_link("Unflag It")

    expect(page).to have_text("You've unflagged The Market")

    visit user_path(current_user)

  end

end

