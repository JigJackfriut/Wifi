class AddCityToManagers < ActiveRecord::Migration[7.0]
  def change
    add_column :managers, :city, :string
  end
end
