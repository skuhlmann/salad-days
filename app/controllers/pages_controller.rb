class PagesController < ApplicationController

  def home
    render layout: "home"
  end

  def search_results
    @results = Market.near(params[:search], 50, order: :distance)
    render :search_results
  end

end
