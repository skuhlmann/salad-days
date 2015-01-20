require "rails_helper"

describe "Permissions", type: :feature do

  it "cannot view someone else's profile page" do
    other_user = create(:user)
    log_in
    visit(user_path(other_user))
    expect(current_path).to eq(root_path)
    expect(page).to have_text("Unauthorized")
  end

   it "cannot manage someone else's market" do
    other_user = create(:user)
    market = create(:market, user_id: other_user.id)
    log_in
    visit(edit_market_path(market.slug))
    expect(current_path).to eq(root_path)
    expect(page).to have_text("Unauthorized")
  end

  it "cannot manage someone else's listing" do
    other_user = create(:user)
    market = create(:market, user_id: other_user.id)
    listing = create(:listing, market_id: market.id)
    log_in
    visit(edit_market_listing_path(market.slug, listing.id))
    expect(current_path).to eq(root_path)
    expect(page).to have_text("Unauthorized")
  end

  it "cannot create someone else's listing" do
    other_user = create(:user)
    market = create(:market, user_id: other_user.id)
    log_in
    visit(new_market_listing_path(market.slug))
    expect(current_path).to eq(root_path)
    expect(page).to have_text("Unauthorized")
  end
end

