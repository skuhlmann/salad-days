class FarmersMarketsController < ApplicationController
  helper_method :escape_address, :clean_name, :distance_from

  def index
    if params[:zip].present?
      @markets = FarmersMarket.find_all_by(params[:zip])
      @user_markets = Market.near(params[:zip], 50)
    else
      @user_markets = Market.all
      flash[:notice] = "Enter a zipcode to narrow your search"
    end
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
