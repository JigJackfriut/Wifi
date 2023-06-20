class CreateZones < ActiveRecord::Migration[7.0]
  def change
    create_table :zones do |t|
      t.string :name
      t.string :description
      t.string :ssid
      t.integer :open
      t.integer :manager_id

      t.timestamps
    end
    add_index :zones, :manager_id
  end
end
