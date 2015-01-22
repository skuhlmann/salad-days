class Markets::ListingsController < ApplicationController
  before_action :set_listing, only: [:edit, :update, :destroy]
  before_action :require_market_owner, except: [:contact]

  def new
    @listing = current_market.listings.new
  end

  def create
    @listing = current_market.listings.new(listing_params)
    if @listing.save
      flash[:notice] = "Listing Added"
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
    @market = current_market
  end

  def update
    if @listing.update_attributes(listing_params)
      flash[:notice] = "Listing Updated"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def contact
    @listing = Listing.find(params[:listing_id])
    MarketMailer.contact_email(@listing, params[:contact_email]).deliver
    flash[:notice] = "Your email was delivered, expect to hear from the market owner shortly"
    redirect_to market_path(@listing.market.slug)
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :description, :harvest_date, :market_id, :active, :image)
  end

  def set_listing
    @listing = current_market.listings.find(params[:id])
  end

  def require_market_owner
    unless current_user && current_user.id == current_market.user_id
      flash[:notice] = "Unauthorized"
      redirect_to root_path
    end
  end
end
