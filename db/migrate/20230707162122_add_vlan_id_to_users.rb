class AddVlanIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :vlan_id, :integer, :default=>0
  end
end
