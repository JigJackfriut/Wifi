class WlanSerializer < ActiveModel::Serializer
  attributes :id, :mac, :name, :description, :status, :wlan, :phy, :txpower, :a, :g, :lastseen, :dateadded, :autochannel, :channel, :client_id
end
