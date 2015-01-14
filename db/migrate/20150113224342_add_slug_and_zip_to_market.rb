class AddSlugAndZipToMarket < ActiveRecord::Migration
  def change
    add_column :markets, :zip, :string
    add_column :markets, :slug, :string
  end
end
