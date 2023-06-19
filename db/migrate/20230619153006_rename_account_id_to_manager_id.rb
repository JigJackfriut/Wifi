class RenameAccountIdToManagerId < ActiveRecord::Migration[7.0]
  def change
  	rename_column :wificlients, :account_id, :manager_id
  end
end
