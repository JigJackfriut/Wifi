class AddManagerIdToUserzones < ActiveRecord::Migration[7.0]
  def change
    add_column :userzones, :manager_id, :integer
    add_index :userzones, :manager_id
  end
end
