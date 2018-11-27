class ChangeWidthInParcels < ActiveRecord::Migration[5.2]
  def change
    rename_column :parcel, :width, :order_from_south
    rename_column :parcel, :length, :size
  end
end
