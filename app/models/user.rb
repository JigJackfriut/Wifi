class User < ApplicationRecord
	#attr_accessor :zone_id, :name
	belongs_to :manager, optional: true
	has_many :zones
end
