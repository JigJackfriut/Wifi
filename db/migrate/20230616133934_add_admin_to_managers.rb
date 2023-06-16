class AddAdminToManagers < ActiveRecord::Migration[7.0]
  def change
    add_column :managers, :admin, :boolean
  end
end
