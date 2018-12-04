class AddStatusToPotagers < ActiveRecord::Migration[5.2]
  def change
    add_column :potagers, :status, :string, default: ''
  end
end
