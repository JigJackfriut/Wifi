include UserzonesHelper
module UsersHelper
	def parseZones(user)
		s=""
		Userzone.where(:user_id => user.id).find_each do |uz|
			zoneID = uz.zone_id 
			zone = Zone.find_by(id: zoneID)
			zoneID = (zoneID).to_s
			zoneName = zone.name		
			s = s + '<%= link_to "'+ zoneName +'", "/zones/'+zoneID+'" %> </br>' 
			
		end 
		puts "Result: #{s}"
		
		
		html = ERB.new(s).result(binding)
		
		return html.html_safe
		
	end
  

	def userUpdate(user, user_params)
		if (user_params[:passphrase] != user.passphrase and user_params[:passphrase]!=nil)
			puts "NEW PASSPHRASE: #{user_params[:passphrase]} OLD PASSPHRASE: #{user.passphrase} NEW NAME: #{user_params[:name]} OLD NAME: #{user.name}"
			
			(Userzone.where(:user_id => user.id)).find_each do |us|
				zone = Zone.find_by(id: us.zone_id) 
				zoneID = zone.id
				genpmk(user_params[:passphrase], zone.ssid, us.id)
				
				Wlan.where( :zone => zoneID).find_each do |wlan|
					client = Wificlient.find_by(id: wlan.client_id)
					client.update(pmk_change: true)
				end 
			end
		end 
	end
	
	def userAddZone(user, user_params)
	
		zoneList = user_params[:zone_list]
		
		if zoneList != nil
			zoneList.each do |zoneID|
			zone = Zone.find_by(id: zoneID)
			userzone = Userzone.find_by(user_id: user, zone_id: zone)
			if !userzone
				userzone = Userzone.create(user_id: user.id, zone_id: zone.id, manager_id: current_manager.id)
				genpmk(user.passphrase, zone.ssid, userzone.id)
			end
		end
	
		Userzone.where(user_id: user).find_each do |uz|
			if !zoneList.include?(uz.zone_id.to_s)
				puts "zone no longer selected! delete! #{uz.id}"
				uz.destroy
			else 
				puts "no userzones need to be cleared!"
			end
		end 
		end
	end 
end
