class CreateWlans < ActiveRecord::Migration[7.0]
  def change
    create_table :wlans do |t|
      t.string :mac
      t.string :name
      t.string :description
      t.string :status
      t.string :wlan
      t.string :phy
      t.string :txpower
      t.string :a
      t.string :g
      t.datetime :lastseen
      t.datetime :dateadded
      t.boolean :autochannel
      t.integer :channel
      t.integer :client_id

      t.timestamps
    end
    add_index :wlans, :client_id
  end
end
