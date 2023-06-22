class RemoveUserIdFromUserzones < ActiveRecord::Migration[7.0]
  def change
    remove_column :userzones, :user_id, :integer
  end
end
