class FarmersMarketsController < ApplicationController
  def index
    @markets = FarmersMarket.find_all_by(params[:zip])
  end

  def show
    @market = FarmersMarket.find(id)
  end
end
