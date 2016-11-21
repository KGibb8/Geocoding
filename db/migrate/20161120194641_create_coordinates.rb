class CreateCoordinates < ActiveRecord::Migration[5.0]
  def change
    create_table :coordinates do |t|
      t.references :expedition, foreign_key: true
      t.float :latitude
      t.float :longitude
      t.integer :accuracy
      t.float :bearing
      t.float :altitude
      t.string :ip
      t.string :country_code
      t.string :country_name
      t.string :region_code
      t.string :region_name
      t.string :city
      t.string :zip_code
      t.string :time_zone

      t.timestamps
    end
  end
end
