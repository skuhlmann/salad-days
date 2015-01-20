class Listing < ActiveRecord::Base
  belongs_to :market

  validates :name, :harvest_date, :market_id, presence: true

  has_attached_file :image,
    styles: {
    listing: '500x300#',
    thumb: '100x100>',
  }

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  scope :active, -> { where(active: true) }
end
