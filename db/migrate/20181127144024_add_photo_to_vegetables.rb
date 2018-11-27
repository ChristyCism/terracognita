class AddPhotoToVegetables < ActiveRecord::Migration[5.2]
  def change
    add_column :vegetables, :photo, :string
  end
end
