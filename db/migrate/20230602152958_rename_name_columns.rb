class RenameNameColumns < ActiveRecord::Migration[7.0]
  def change
	rename_column :accounts, :first, :first_name
	rename_column :accounts, :last, :last_name
  end
end
