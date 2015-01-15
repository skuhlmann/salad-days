require 'rails_helper'

describe SessionsController do

  describe "session features", type: :feature do
      it "signs up a new user" do
        @request.env["omniauth.auth"] = {
          'provider' => 'twitter',
          'uid' => 'abc123',
          'info' => {'name' => 'Colleen Kuhlmann',
                    'location' => 'Denver',
                    'description' => 'A description',
                    'image' => "http://pbs.twimg.com/profile_images/418471271018418176/Ld5_oUEd_normal.jpeg"}
            }

        post :create
        user = User.find_by(uid: 'abc123')
        expect(controller.current_user.id).to eq(user.id)
        expect(response).to redirect_to(user_path(user))
      end

      it "logs in an existing user" do
        user = User.create(provider: 'twitter', uid: 'xyz456', name: 'Dwight Gooden')
        @request.env["omniauth.auth"] = {
          'provider' => 'twitter',
          'uid' => 'xyz456',
          'info' => {'name' => 'Dwight Gooden',
                    'location' => 'NYC',
                    'description' => 'A description',
                    'image' => "http://pbs.twimg.com/profile_images/418471271018418176/Ld5_oUEd_normal.jpeg"}
            }
        post :create
        expect(User.count).to eq(1)
        expect(controller.current_user.id).to eq(user.id)
      end
  end
end
