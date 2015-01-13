class Market < ActiveRecord::Base
  has_many :listings
  has_attached_file :image,
    styles: {
    listing: '500x300#',
    thumb: '100x100>',
  }

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

end
