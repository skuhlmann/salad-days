class AddMarketToListings < ActiveRecord::Migration
  def change
    add_reference :listings, :market, index: true
  end
end
