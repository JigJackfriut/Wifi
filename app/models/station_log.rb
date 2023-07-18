class StationLog < ApplicationRecord
	belongs_to :manager, optional: true
end
