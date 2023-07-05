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
		if (user_params[:passphrase] != user.ssid)
		puts "YPPPPPPPPPPPPPPPPHGP LOOOKKSNNSN"
			client = Wificlient.find_by(id: user.client_id)
			client.update(update_needed: true)
			puts "update needed!" 
		else
			puts "update not needed!" 
		end 
	end
	
	def userAddZone(user, user_params)
		puts "params: #{user_params}"
		zoneList = user_params[:zone]
		puts "zoneList: #{zoneList}"
		zoneList.each do |zoneID|
			zone = Zone.find_by(id: zoneID)
			Userzone.create(user_id: user.id, zone_id: zone.id)
		end
	end 
	
	
end
