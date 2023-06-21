class Zone < ApplicationRecord
	#attr_accessor :user_id, :name
	belongs_to :manager
end
