class CreateMarkets < ActiveRecord::Migration
  def change
    create_table :markets do |t|
      t.string :name
      t.string :google_link
      t.string :address
      t.string :schedule
      t.string :products

      t.timestamps
    end
  end
end
