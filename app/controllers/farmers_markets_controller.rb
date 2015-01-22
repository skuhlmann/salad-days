class FarmersMarketsController < ApplicationController
  helper_method :escape_address, :clean_name, :distance_from

  def index
    @markets = FarmersMarket.find_all_by(params[:zip])
  end

  def show
    @market = FarmersMarket.find(id)
  end

  private

  def escape_address(address)
    address.gsub(/ +/, "+")
  end

  def clean_name(marketname)
    marketname.split(" ")[1..-1].join(" ")
  end

  def distance_from(marketname)
    marketname.split(" ")[0]
  end

end
