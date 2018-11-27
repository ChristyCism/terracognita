class ChangeWidthInParcels < ActiveRecord::Migration[5.2]
  def change
    rename_column :parcels, :width, :order_from_south
    rename_column :parcels, :length, :size
  end
end
