class MarketsController < ApplicationController
  before_action :set_market, only: [:show, :edit, :destory]
  before_action :require_market_owner, only: [:edit, :destroy]
  helper_method :successful_search?, :empty_search?

  def index
    if params[:zip].present?
      @markets = Market.near(params[:zip], 50)
    else
      @markets = Market.all
      flash[:notice] = "Enter a zipcode to narrow your search"
    end
  end

  def show
    if @market.nil?
      flash[:notice] = "Market doesn't exist"
      redirect_to root_path
    end
  end

  def new
    @market = Market.new
  end

  def create
    @market = Market.create(market_params)
    if @market.save
      flash[:notice] = "Market was successfully created."
      redirect_to market_path(@market.slug)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @market = Market.find(params[:slug])
    require_market_owner
    if @market.update_attributes(market_params)
      flash[:notice] = "Market details updated."
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def market_params
    params.require(:market).permit(:user_id, :email, :name, :street, :zip, :city, :state, :products, :image)
  end

  def set_market
    @market = Market.find_by(slug: params[:slug])
  end

  def require_market_owner
    unless current_user && current_user.id == @market.user_id
      flash[:notice] = "Unauthorized"
      redirect_to root_path
    end
  end

  def successful_search?
    params[:zip].present? && @markets.any?
  end

  def empty_search?
    params[:zip] && @markets.empty?
  end
end
