class CreateVegetablesParcels < ActiveRecord::Migration[5.2]
  def change
    create_table :vegetables_parcels do |t|
      t.references :parcel, foreign_key: true
      t.references :vegetable, foreign_key: true

      t.timestamps
    end
  end
end
