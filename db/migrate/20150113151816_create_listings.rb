class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :name
      t.string :description
      t.date :harvest_date
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
