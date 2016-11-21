class CreateExpeditions < ActiveRecord::Migration[5.0]
  def change
    create_table :expeditions do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
