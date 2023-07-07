include UserzonesHelper
module UsersHelper
	def parseZones(arr)
		if arr == nil 
			return 
		end 
		stringparse = arr
		b = JSON.parse(stringparse) 
		s= [] 
		b.each do |n|
			s.append(n)
		end 
		puts "Result: #{s}"
		return s 
	
	end
  

	def userUpdate(user, user_params)
		if (user_params[:passphrase] != user.passphrase and user_params[:passphrase]!=nil)
			puts "NEW PASSPHRASE: #{user_params[:passphrase]} OLD PASSPHRASE: #{user.passphrase} NEW NAME: #{user_params[:name]} OLD NAME: #{user.name}"
			
			(Userzone.where(:user_id => user.id)).find_each do |us|
				puts "YPPPPPPPPPPPPPPPPHGP LOOOKKSNNSN"
				zone = Zone.find_by(id: us.zone_id) 
				zoneID = zone.id
				genpmk(user_params[:passphrase], zone.ssid, us.id)
				
				Wlan.where( :zone => zoneID).find_each do |wlan|
					puts "checkpoint 2!" 
					client = Wificlient.find_by(id: wlan.client_id)
					client.update(pmk_change: true)
					puts "client ID! : #{client.id}"
				end 
			end
			
			#client = Wificlient.find_by(id: user.client_id)
			#client.update(pmk_change: true)
			puts "update needed!" 
		else
			puts "update not needed!" 
		end 
	end
	
	def userAddZone(user, user_params)
		puts "params: #{user_params}"
		zoneList = user_params[:zone_list]
		puts "zoneList: #{zoneList}"
		zoneList.each do |zoneID|
			zone = Zone.find_by(id: zoneID)
			userzone = Userzone.create(user_id: user.id, zone_id: zone.id)
			genpmk(user.passphrase, zone.ssid, userzone.id)
			
		end
	end 
	
	
end
