require 'rails_helper'

RSpec.describe Market, :type => :model do

  before(:each) do
    @farmers_market = OpenStruct.new(id: "1006047",
                   marketname: "3.3 Cherry Creek Fresh Market",
                   Address: "3000 East First Avenue, Denver, Colorado, 80206",
                   GoogleLink: "http://maps.google.com/?q=39.716756%2C%20-104.958073%20(%22Cherry+Creek+Fresh+Market%22)",
                   Products: "Baked goods; Cheese and/or dairy products; Crafts and/or woodworking items; Cut flowers; Eggs; Fish and/or seafood; Fresh fruit and vegetables; Fresh and/or dried herbs; Honey; Canned or preserved fruits, vegetables, jams, jellies, preserves, salsas, pickles, dried fruit, etc.; Maple syrup and/or maple products; Meat; Nuts; Plants in containers; Poultry; Prepared foods (for immediate consumption); Soap and/or body care products; Wine, beer, hard cider",
                   Schedule: "05/03/2014 to 10/25/2014 Wed: 9:00 AM-1:00 PM;Sat: 8:00 AM-1:00 PM;<br> <br> <br> "
                  )
  end

end


