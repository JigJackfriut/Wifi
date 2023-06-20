class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :type
      t.string :passphrase
      t.integer :manager_id
      t.string :zone

      t.timestamps
    end
    add_index :users, :manager_id
  end
end
