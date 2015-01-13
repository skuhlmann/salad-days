class AddPaperclipFieldsToListingAndMarket < ActiveRecord::Migration
  def change
    add_column :listings, :image_file_name,    :string
    add_column :listings, :image_content_type, :string
    add_column :listings, :image_file_size,    :integer
    add_column :listings, :image_updated_at,   :datetime
    add_column :markets, :image_file_name,    :string
    add_column :markets, :image_content_type, :string
    add_column :markets, :image_file_size,    :integer
    add_column :markets, :image_updated_at,   :datetime
  end
end
