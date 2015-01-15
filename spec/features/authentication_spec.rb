require "rails_helper"

describe "Authentication flow", type: :feature do

  it "can sign up with twitter" do
    log_in
    expect(page).to have_text("Trevor")
    expect(page).to have_text("Denver")
    expect(page).to have_text("Create a Market")
  end

  it "can log into an existing accout with twitter" do
    user = User.create(name: "Trevor", provider: "twitter", uid: "testuid")
    user.market = build(:market)
    log_in
    expect(page).to have_text("The Market")
  end
end


