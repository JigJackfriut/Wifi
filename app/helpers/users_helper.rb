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
		if (user_params[:passphrase] != user.passphrase) or (user_params[:name] != user.name)
			puts "NEW PASSPHRASE: #{user_params[:passphrase]} OLD PASSPHRASE: #{user.passphrase} NEW NAME: #{user_params[:name]} OLD NAME: #{user.name}"
			(Userzone.where(:user_id => user.id)).find_each do |us|
				puts "YPPPPPPPPPPPPPPPPHGP LOOOKKSNNSN"
				zone = us.zone_id
				Wlan.where( :zone => zone).find_each do |wlan|
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
			Userzone.create(user_id: user.id, zone_id: zone.id)
		end
	end 
	
	
end
