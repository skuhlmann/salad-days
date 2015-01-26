class MarketsController < ApplicationController
  before_action :set_market, only: [:show, :edit, :destory, :flag]
  before_action :require_market_owner, only: [:edit, :destroy]
  helper_method :is_flagged?

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

  def flag
   @market = Market.find(params[:market_id])
   if @market.flags.create(user_id: current_user.id)
     flash[:notice] = "You've flagged #{@market.name}"
     redirect_to market_path(@market.slug)
   end
  end

  def unflag
   @market = Market.find(params[:market_id])
   @flag = Flag.find_by(market_id: params[:market_id], user_id: current_user.id)
   if @flag.destroy
     flash[:notice] = "You've unflagged #{@market.name}"
     redirect_to market_path(@market.slug)
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

  def is_flagged?
    current_user && current_user.flags.any? {|flag| flag.market_id == @market.id}
  end
end
