class AddAccounttypeToManagers < ActiveRecord::Migration[7.0]
  def change
    add_column :managers, :account_type, :string
  end
end
