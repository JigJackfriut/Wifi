class AddZipToManagers < ActiveRecord::Migration[7.0]
  def change
    add_column :managers, :zip, :string
  end
end
