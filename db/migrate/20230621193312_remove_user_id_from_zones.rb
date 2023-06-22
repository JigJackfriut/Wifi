class RemoveUserIdFromZones < ActiveRecord::Migration[7.0]
  def change
  	remove_column :zones, :user_id, :string
  end
end
