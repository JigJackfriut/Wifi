class User < ApplicationRecord
	#attr_accessor :zone_id, :name
	belongs_to :manager, optional: true
	#has_and_belongs_to_many :zones
	has_many :zones
	belongs_to :zones
end
