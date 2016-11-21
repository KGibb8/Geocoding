class CreateAnnotations < ActiveRecord::Migration[5.0]
  def change
    create_table :annotations do |t|
      t.references :coordinate, foreign_key: true
      t.string :image
      t.string :recording
      t.string :note

      t.timestamps
    end
  end
end
