class Market < ActiveRecord::Base
  has_many :listings

  validates :name, uniqueness: true
  validates :slug, uniqueness: true

  before_save :generate_slug

  has_attached_file :image,
    styles: {
    listing: '500x300#',
    thumb: '100x100>',
  }

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  def generate_slug
    self.slug = name.parameterize
  end
end
