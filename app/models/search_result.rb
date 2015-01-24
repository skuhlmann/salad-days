class SearchResult

  def self.find_results(zip)
    build_combined_collection(
      build_farmers_collection(fetch_farmers_markets(zip)),
      build_users_collection(fetch_users_markets(zip))
    ).sort {|a, b| a.first <=> b.first }
  end

  private

  def self.fetch_farmers_markets(zip)
    FarmersMarket.find_all_by(zip)
  end

  def self.fetch_users_markets(zip)
    Market.near(zip, 25)
  end

  def self.build_farmers_collection(markets)
    markets.map { |market| [distance_from(market.marketname), market] }
  end

  def self.build_users_collection(markets)
    markets.map { |market| [market.distance.round(1), market] }
  end

  def self.distance_from(marketname)
    marketname.split(" ")[0].to_f
  end

  def self.build_combined_collection(farmers_market, users_market)
    farmers_market.concat(users_market)
  end
end
