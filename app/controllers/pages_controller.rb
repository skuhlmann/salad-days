class PagesController < ApplicationController

  def home
    render layout: "home"
  end

  def search_results
    @results = Listing.all
    @markets = Market.all
  end
end
