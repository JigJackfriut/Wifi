class WificlientSerializer < ActiveModel::Serializer
  attributes :location, :ownerid, :enabled, :status
end
