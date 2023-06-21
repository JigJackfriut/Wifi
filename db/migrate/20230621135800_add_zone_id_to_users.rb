class AddZoneIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :zone_id, :integer
    add_index :users, :zone_id
  end
end
