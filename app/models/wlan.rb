class Wlan < ApplicationRecord
	belongs_to :wificlient, optional: true
end
