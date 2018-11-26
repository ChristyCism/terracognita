class CreateParcels < ActiveRecord::Migration[5.2]
  def change
    create_table :parcels do |t|
      t.references :potager, foreign_key: true
      t.integer :length
      t.integer :width

      t.timestamps
    end
  end
end
