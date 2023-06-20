class ZoneSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :ssid, :open, :manager_id
end
