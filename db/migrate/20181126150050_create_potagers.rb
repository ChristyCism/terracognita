class CreatePotagers < ActiveRecord::Migration[5.2]
  def change
    create_table :potagers do |t|
      t.references :user, foreign_key: true
      t.integer :length
      t.integer :width
      t.boolean :freeze
      t.string :orientation
      t.string :start_month

      t.timestamps
    end
  end
end
