require 'rails_helper'

RSpec.describe FarmersMarket, :type => :model do

  describe "market service api calls" do

    it "calls the service to get market overviews" do
      VCR.use_cassette("market_service") do
        service = MarketService.new
        results = service.farmers_markets("80203")
        expect(results["results"].first.include?("id"))
        expect(results["results"].first.include?("marketname"))
        expect(results["results"].first["marketname"]).to eq("0.6 VNA Farmers' Market")
      end
    end

    it "calls the service to get more market details" do
      VCR.use_cassette("market_service_1") do
        service = MarketService.new
        results = service.farmers_market("1005360")
        expect(results["marketdetails"].keys).to eq(["Address", "GoogleLink", "Products", "Schedule"])
        expect(results["marketdetails"]["Address"]).to eq("390 Grant St., Denver, Colorado")
      end

    end
  end

  describe "finding all markets by zip" do
    before(:each) do
      VCR.use_cassette("farmers_markets") do
        @markets = FarmersMarket.find_all_by("80205")
      end
    end

    it "gets all markets in the area" do
      expect(@markets.count).to eq(19)
      expect(@markets.first.marketname).to eq("1.6 Tiri's Garden Farmers' Market")
    end

    it "build markets with a full set of attributes" do
      expect(@markets.first.Address).to eq("1522 California St., Denver, Colorado")
      expect(@markets.first.distance).to eq(1.6)
      expect(@markets[1].Schedule).to include("06/01/2014")
      expect(@markets[1].Products).to include("Maple syrup")
    end
  end

  describe "building the market objects" do
    it "build the market overview" do
      data = {"id"=>"1005360", "marketname"=>"0.6 VNA Farmers' Market"}
      results = FarmersMarket._build_object(data)

      expect(results.class).to eq(OpenStruct)
      expect(results.id).to eq("1005360")
      expect(results.marketname).to eq("0.6 VNA Farmers' Market")
    end

    it "adds more market attributes" do
      data = {"id"=>"1005360", "marketname"=>"0.6 VNA Farmers' Market"}
      market = FarmersMarket._build_object(data)
      VCR.use_cassette("farmers_markets_2") do
        results = FarmersMarket._add_attribute_details(market)
        expect(results.Address).to eq("390 Grant St., Denver, Colorado")
        expect(results.distance).to eq(0.6)
      end
    end
  end
end


