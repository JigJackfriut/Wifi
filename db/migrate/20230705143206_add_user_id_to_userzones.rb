class AddUserIdToUserzones < ActiveRecord::Migration[7.0]
  def change
    add_column :userzones, :user_id, :integer
    add_index :userzones, :user_id
  end
end
