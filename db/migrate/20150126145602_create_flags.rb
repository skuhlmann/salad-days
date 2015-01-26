class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.references :user, index: true
      t.references :market, index: true

      t.timestamps
    end
  end
end
