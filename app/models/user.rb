class User < ActiveRecord::Base
  validates :name, :uid, :provider, presence: true
  validates :uid, uniqueness: true
  has_one :market

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.image = auth["info"]["image"]
      user.location = auth["info"]["location"]
      user.description = auth["info"]["description"]
    end
  end
end
