json.extract! wlan, :id, :mac, :name, :description, :status, :wlan, :phy, :txpower, :a, :g, :lastseen, :dateadded, :autochannel, :channel, :client_id, :created_at, :updated_at
json.url wlan_url(wlan, format: :json)
