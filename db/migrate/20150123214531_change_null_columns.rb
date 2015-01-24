class ChangeNullColumns < ActiveRecord::Migration
  def change
    change_column_null :listings, :name, false
    change_column_null :listings, :market_id, false
    change_column_null :listings, :harvest_date, false
    change_column_null :markets, :name, false
    change_column_null :markets, :user_id, false
    change_column_null :markets, :street, false
    change_column_null :markets, :city, false
    change_column_null :markets, :state, false
    change_column_null :markets, :zip, false
    change_column_null :users, :name, false
    change_column_null :users, :uid, false
    change_column_null :users, :provider, false
  end
end
