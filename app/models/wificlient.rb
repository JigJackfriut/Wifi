class Wificlient < ApplicationRecord
	belongs_to :manager, optional: true
	has_many :wlan
end
