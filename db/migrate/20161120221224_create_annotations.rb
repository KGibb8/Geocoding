class CreateAnnotations < ActiveRecord::Migration[5.0]
  def change
    create_table :annotations do |t|
      t.references :coordinate, foreign_key: true
      t.string :image
      t.string :recording
      t.text :note
      t.string :content_type
      t.string :full_path

      t.timestamps
    end
  end
end
