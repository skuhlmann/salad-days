class FarmersMarket

  def self.service
    @service ||= MarketService.new
  end

  def self.find_all_by(zip)
    service.farmers_markets(zip)["results"].map do |market_overview|
     _add_attribute_details( _build_object(market_overview))
    end
  end

  private

  def self._build_object(data)
    OpenStruct.new(data)
  end

  def self._add_attribute_details(market)
    markets = service.farmers_market(market.id)["marketdetails"]
    markets.each_with_object(market) do |(key, value), market_overview |
      market_overview[key] = value
    end
  end
end