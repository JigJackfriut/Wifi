class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :passphrase, :manager_id, :zone
end
