class AddAddress2ToManagers < ActiveRecord::Migration[7.0]
  def change
    add_column :managers, :address2, :string
  end
end
