require "rails_helper"

describe "Market owner flow", type: :feature do

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
  end

end


