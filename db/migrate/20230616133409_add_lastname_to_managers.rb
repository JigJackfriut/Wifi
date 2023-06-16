class AddLastnameToManagers < ActiveRecord::Migration[7.0]
  def change
    add_column :managers, :last_name, :string
  end
end
