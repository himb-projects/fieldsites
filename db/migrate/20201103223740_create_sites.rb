class CreateSites < ActiveRecord::Migration[6.0]
  def change
    create_table :sites do |t|
      t.string :site_name
      t.text :site_description
      t.decimal :latitude
      t.decimal :longitude
      t.string :color
      t.boolean :shared
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
