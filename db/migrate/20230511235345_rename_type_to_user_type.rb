class RenameTypeToUserType < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :type, :usertype
  end
end
