require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, :type => :model do

  describe "User Abilities" do
    it "should be able to manage it's market" do
      user = create(:user)
      market = create(:market, user_id: user.id)
      ability = Ability.new(user)

      expect(ability).to be_able_to(:destroy, market)
      expect(ability).to be_able_to(:edit, market)
      expect(ability).to be_able_to(:udpate, market)
    end

    it "should not be able to manage some other market" do
      user = create(:user)
      another_user = create(:user, uid: "987xyz")
      market = create(:market, user_id: another_user.id)
      binding.pry

      ability = Ability.new(user)

      expect(ability).not_to be_able_to(:destroy, market)
      expect(ability).not_to be_able_to(:edit, market)
      expect(ability).not_to be_able_to(:update, market)
    end
  end
end


