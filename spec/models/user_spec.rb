require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:valid_attributes) { {
    name: "Colleen Kuhlmann",
    uid: "181818181818181",
    provider: "twitter"
    } }

    let(:invalid_attributes) { {
      name: nil,
      uid: nil,
      provider: nil
      } }

    describe "user attributes" do
      it "must be valid" do
        user = User.create(valid_attributes)
        invalid_user = User.create(invalid_attributes)
        expect(user).to be_valid
        expect(invalid_user).not_to be_valid
      end

      it "must have a name" do
        user = User.create(valid_attributes)
        user.name = nil
        expect(user).not_to be_valid
      end

      it "must have a uid" do
        user = User.create(valid_attributes)
        user.uid = nil
        expect(user).not_to be_valid
      end

      it "must have a provider" do
        user = User.create(valid_attributes)
        user.provider = nil
        expect(user).not_to be_valid
      end

      it "should have a unique uid" do
        user = User.create(valid_attributes)
        user_again = User.create(valid_attributes)
        expect(user).to be_valid
        expect(user_again).not_to be_valid
      end
    end

    describe "user relationships" do
      it "can have one market" do
        user = User.create(valid_attributes)
        expect(user).to respond_to(:market)
      end
    end

    describe "omniauth creation" do
      it "can be created with omniauth" do
        auth = {"provider" => "twitter",
                "uid" => "1234567890",
                "info" => {"name" => "Joe Strummer"}
                }
        user = User.create_with_omniauth(auth)
        expect(user).to be_valid
        expect(user.name).to eq("Joe Strummer")
      end
    end
end
