class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_market

  def current_market
    @current_market ||= Market.find_by(slug: session[:market_slug])
  end
end
