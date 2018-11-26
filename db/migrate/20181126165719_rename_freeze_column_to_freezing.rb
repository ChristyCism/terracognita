class RenameFreezeColumnToFreezing < ActiveRecord::Migration[5.2]
  def change
    rename_column :potagers, :freeze, :freezing
  end
end
