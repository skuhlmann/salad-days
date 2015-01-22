require "rails_helper"

describe "Farmers market listing user", type: :feature do

  it "can browse a farmers market listing by zip code" do
    visit root_path
    fill_in("zip", with: "80205")
    click_button("Search")

    expect(page).to have_text("Tiri's Garden Farmers")
    expect(page).to have_text("City Park Esplanade Fresh Market")
    expect(page).to have_text("Stapleton Farmers Market")
    expect(page).to have_text("1001 Osage Street, Denver, Colorado, 80204")
    expect(page).to have_text("05/03/2014 to 10/25/2014 Wed: 9:00 AM-1:00 PM;Sat: 8:00 AM-1:00 PM")
  end
end

