class AddAddressAttributesToMarket < ActiveRecord::Migration
  def change
    rename_column :markets, :address, :full_address
    add_column :markets, :street, :string
    add_column :markets, :city, :string
    add_column :markets, :state, :string
  end
end
