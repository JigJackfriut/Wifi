class AddManagerIdToWlans < ActiveRecord::Migration[7.0]
  def change
    add_column :wlans, :manager_id, :integer
    add_index :wlans, :manager_id
  end
end
