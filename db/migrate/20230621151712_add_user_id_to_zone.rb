class AddUserIdToZone < ActiveRecord::Migration[7.0]
  def change
    add_column :zones, :user_id, :integer
    add_index :zones, :user_id
  end
end
