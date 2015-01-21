class MarketService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: "http://search.ams.usda.gov/farmersmarkets/v1/data.svc/")
  end

  def farmers_markets(zip)
    parse(connection.get("zipSearch?zip=#{zip}"))
  end

  def farmers_market(id)
    parse(connection.get("mktDetail?id=#{id}"))
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end
end
