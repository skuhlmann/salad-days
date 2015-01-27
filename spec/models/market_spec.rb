require 'rails_helper'

RSpec.describe Market, :type => :model do
  let(:valid_attributes) { {
    name: "A Market Name",
    email: "market-email@example.com",
    street: "123 Main St.",
    city: "Denver",
    state: "CO",
    zip: "80205",
    user_id: 1
    } }

    let(:invalid_attributes) { {
      name: nil,
      email: nil,
      street: nil,
      city: nil,
      state: nil,
      zip: nil,
      user_id: nil
      } }

    describe "market attributes" do
      before(:each) do
        @market = Market.create(valid_attributes)
      end

      it "must be valid" do
        invalid_market = Market.create(invalid_attributes)
        expect(@market).to be_valid
        expect(invalid_market).to be_invalid
      end

      it "can generate a full address" do
        expect(@market.full_address).to eq("123 Main St., Denver, CO, 80205")
      end

      it "must have a name" do
        @market.name = nil
        expect(@market).not_to be_valid
      end

      it "must have a user id" do
        @market.user_id = nil
        expect(@market).not_to be_valid
      end

      it "must have an email" do
        @market.email = nil
        expect(@market).not_to be_valid
      end

      it "must have a plausible email" do
        @market.email = "fdkjdfjh"
        expect(@market).not_to be_valid

        @market.email = "sam.com"
        expect(@market).not_to be_valid

        @market.email = "@gmail.com"
        expect(@market).not_to be_valid
      end

      it "must have a street" do
        @market.city = nil
        expect(@market).not_to be_valid
      end

      it "must have a state" do
        @market.state = nil
        expect(@market).not_to be_valid
      end

      it "must have a state abbreviation" do
        @market.state = "colorado"
        expect(@market).not_to be_valid
        @market.state = "c"
        expect(@market).not_to be_valid
      end

      it "must have a zip" do
        @market.zip = nil
        expect(@market).not_to be_valid
      end

      it "must have a 5 digit zip" do
        @market.zip = "75"
        expect(@market).not_to be_valid
        @market.zip = "754785437509347"
        expect(@market).not_to be_valid
      end

      it "must have a unique user id" do
         another_market = Market.create({
            name: "Another Market Name",
            email: "email@example.com",
            street: "123 Main St.",
            city: "Denver",
            state: "CO",
            zip: "80205",
            user_id: 1
            })
         expect(another_market).not_to be_valid
       end

       it "must have a unique name" do
         another_market = Market.create({
            name: "A Market Name",
            email: "email@example.com",
            street: "123 Main St.",
            city: "Denver",
            state: "CO",
            zip: "80205",
            user_id: 2
            })
         expect(another_market).not_to be_valid
       end

        it "must have a unique email" do
         another_market = Market.create({
            name: "Another Market Name",
            email: "market-email@example.com",
            street: "123 Main St.",
            city: "Denver",
            state: "CO",
            zip: "80205",
            user_id: 2
            })
         expect(another_market).not_to be_valid
       end
    end

    describe "market realtionships" do
      it "belongs to a user" do
        market = Market.create(valid_attributes)
        expect(market).to respond_to(:user)
      end

      it "has many listings" do
        market = Market.create(valid_attributes)
        expect(market).to respond_to(:listings)
      end

      it "provides a list of it's active listings" do
        market = Market.create(valid_attributes)
        listing = create(:listing, market: market)

        expect(market.listings.active).to eq([listing])

        listing.active = false
        listing.save
        expect(market.listings.active).to be_empty
      end

      it "has many flags" do
        market = Market.create(valid_attributes)
        expect(market).to respond_to(:flags)
      end

      it "has many users that have flagged it" do
        market = Market.create(valid_attributes)
        expect(market).to respond_to(:flagged_users)
      end
    end
end
