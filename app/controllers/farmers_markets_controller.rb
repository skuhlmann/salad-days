class FarmersMarketsController < ApplicationController
  helper_method :escape_address

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

end
