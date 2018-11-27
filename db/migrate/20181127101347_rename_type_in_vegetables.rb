class RenameTypeInVegetables < ActiveRecord::Migration[5.2]
  def change
    rename_column :vegetables, :type, :vegetabletype
    add_column :vegetables, :frost_resistant, :integer
  end
end
