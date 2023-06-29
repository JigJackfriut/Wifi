class Wlan < ApplicationRecord
	belongs_to :manager, optional: true
	belongs_to :wificlient, optional: true
	enum modes: { "A" => "A", "G" => "G"}
end
