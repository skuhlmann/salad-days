class AddEmailToMarket < ActiveRecord::Migration
  def change
    add_column :markets, :email, :string
  end
end
