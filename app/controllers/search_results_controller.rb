class SearchResultsController < ApplicationController
  helper_method :escape_address, :clean_name, :distance_from, :farmers_market?

  def index
    if params[:zip].present?
      @markets = SearchResult.find_results(params[:zip])
    else
      @markets = []
      flash[:notice] = "Enter a zipcode to find markets in your area"
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

  def farmers_market?(market)
    market.instance_of?(OpenStruct)
  end
end
