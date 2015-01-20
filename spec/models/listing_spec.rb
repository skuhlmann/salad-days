require 'rails_helper'

RSpec.describe Listing, :type => :model do
  let(:valid_attributes) { {
    name: "A Listing Name",
    description: "Listing description",
    harvest_date: Date.current,
    market_id: 1,
    } }

    let(:invalid_attributes) { {
      name: nil,
      harvest_date: nil,
      market_id: nil,
      } }

    describe "listing attributes" do
      before(:each) do
        @listing = Listing.create(valid_attributes)
      end

      it "must have valid attibutes" do
        invalid_listing = Listing.create(invalid_attributes)
        expect(@listing).to be_valid
        expect(invalid_listing).not_to be_valid
      end

      it "must have a name" do
        @listing.name = nil
        expect(@listing).not_to be_valid
      end

      it "must have a harvest date" do
        @listing.harvest_date = nil
        expect(@listing).not_to be_valid
      end

      it "must have a market id" do
        @listing.market_id = nil
        expect(@listing).not_to be_valid
      end

      describe "listing relationships" do
        it "belongs to a market" do
          @listing = Listing.create(valid_attributes)
          expect(@listing).to respond_to(:market)
        end
      end
    end

  end
