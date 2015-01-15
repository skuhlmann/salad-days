class AddUserToMarket < ActiveRecord::Migration
   def change
    add_reference :markets, :user, index: true
  end
end
