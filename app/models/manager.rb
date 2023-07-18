class Manager < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         has_many :wificlients
         has_many :wlans
         has_many :users
         has_many :zones
         has_many :userzones
		 has_many :station_logs
end
