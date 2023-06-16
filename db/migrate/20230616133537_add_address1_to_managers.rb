class AddAddress1ToManagers < ActiveRecord::Migration[7.0]
  def change
    add_column :managers, :address1, :string
  end
end
