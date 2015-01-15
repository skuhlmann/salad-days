class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_market
  helper_method :current_user

  def current_market
    @current_market ||= Market.find_by(slug: params[:market_slug])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
