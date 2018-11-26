class CreateVegetables < ActiveRecord::Migration[5.2]
  def change
    create_table :vegetables do |t|
      t.string :name
      t.string :type
      t.string :month_planted, array: true
      t.integer :distance_between
      t.integer :luminosity
      t.integer :humidity
      t.integer :height
      t.integer :harvest_time
      t.string :aromatics, array: true
      t.string :friends, array: true
      t.string :ennemies, array: true

      t.timestamps
    end
  end
end
