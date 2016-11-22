class AddDistanceToCoordinate < ActiveRecord::Migration[5.0]
  def change
    add_column :coordinates, :distance_to_last, :float
  end
end
