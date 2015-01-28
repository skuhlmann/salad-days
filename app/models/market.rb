class Market < ActiveRecord::Base
  has_many :listings
  has_many :flags
  has_many :flagged_users, through: :flags, source: :user
  belongs_to :user

  validates :name, :user_id, :email, :street, :city, :state, :zip, presence: true
  validates :name, :slug, :email, :user_id, uniqueness: true
  validates :email, format: { with:  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :zip, length: { is: 5, message: "Must be 5 digits long" }
  validates :state, length: { is: 2, message: "Must be a two character abbreviation" }

  before_save :generate_slug, :generate_full_address

  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.full_address.present? and obj.full_address_changed? }

  has_attached_file :image,
    styles: {
    hero: '600x400#',
    listing: '500x300#',
    thumb: '100x100>',
  }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  def generate_slug
    self.slug = name.parameterize
  end

  def generate_full_address
    self.full_address = "#{street}, #{city}, #{state}, #{zip}"
  end

  def escape_address
    full_address.gsub(/ +/, "+")
  end

end
