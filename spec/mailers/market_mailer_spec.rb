require "rails_helper"

RSpec.describe MarketMailer, :type => :mailer do
  it "can notify a market owner that a someone is interested in her listing" do
    user = create(:user)
    market = create(:market, user: user)
    listing = create(:listing, market: market)

    result = MarketMailer.contact_email(listing, market.email).deliver

    expect(result).not_to be_nil
    expect(result.to.first).to eq(market.email)
    expect(result.from.first).to eq("no-reply@saladdays.xyz")
    expect(result.subject).to eq("Salad Days Listing Inquiry")
    expect(result.body).to include(listing.name)
    expect(result.body).to include(listing.description)
    expect(result.body).to include(listing.harvest_date)
  end

  it "can email followers when a market adds a listing" do
    user = create(:user)
    market = create(:market, user: user)
    listing = create(:listing, market: market)

    result = MarketMailer.new_listing_email(user, listing).deliver

    expect(result).not_to be_nil
    expect(result.to.first).to eq(user.market.email)
    expect(result.from.first).to eq("no-reply@saladdays.xyz")
    expect(result.subject).to eq("Salad Days The Market has added some fresh food")
    expect(result.body).to include(listing.name)
    expect(result.body).to include(listing.description)
    expect(result.body).to include(listing.harvest_date)
  end
end
