class Userzone < ApplicationRecord
	belongs_to :manager, optional: true
end
