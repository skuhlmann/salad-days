class PagesController < ApplicationController

  def home
  end

  def search_results
    @results = Listing.all
    @markets = Market.all
  end
end
