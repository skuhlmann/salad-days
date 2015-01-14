class MarketsController < ApplicationController
  before_action :set_market, only: [:show, :edit, :destory]

  def show
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
    if @market.update_attributes(market_params)
      flash[:notice] = "Market was successfully updated."
      redirect_to market_path(@market.slug)
    else
      render :edit
    end
  end

  def destroy
    binding.pry

    @market.destroy
    redirect_to root_path
  end

  private

  def market_params
    params.require(:market).permit(:name, :street, :zip, :city, :state, :products, :image)
  end

  def set_market
    @market = Market.find_by(slug: params[:slug])
  end

end