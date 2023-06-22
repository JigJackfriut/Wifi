class Zone < ApplicationRecord
	#attr_accessor :user_id, :name
	belongs_to :manager, optional: true
	has_and_belongs_to_many :users
end
