class AddFirstnameToManagers < ActiveRecord::Migration[7.0]
  def change
    add_column :managers, :first_name, :string
  end
end
