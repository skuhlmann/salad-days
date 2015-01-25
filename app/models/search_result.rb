class SearchResult

  def self.find_results(zip)
    sort_by_distance(farmers_markets(zip).concat(users_markets(zip)))
  end

  def self.farmers_markets(zip)
    FarmersMarket.find_all_by(zip)
  end

  def self.users_markets(zip)
    Market.near(zip, 25)
  end

  def self.sort_by_distance(markets)
    markets.sort_by { |market| market.distance }
  end
end
