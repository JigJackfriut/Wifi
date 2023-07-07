include UserzonesHelper
module ZonesHelper
	def displayArray(arr)
		if arr == nil 
			return 
		end 
		s=""
		first = true
		arr.each do |n|
			if not first
				s=s+", "
			end 
			s=s+n 
			first=false
		end 
		puts "Result: #{s}"
		return s 
  end
  
  def zoneUpdate(zone, zone_params)
		if (zone_params[:ssid] != zone.ssid and zone_params[:ssid] != nil)
			puts "NEW SSID #{zone_params[:ssid]} OLD SSID #{zone.ssid}"
			
			(Userzone.where(:zone_id => zone.id)).find_each do |us|
				user = User.find_by(id: us.user_id) 
				genpmk(user.passphrase, zone_params[:ssid], us.id)
			end
			
			Wlan.where( :zone => zone).find_each do |wlan|
					puts "checkpoint 2!" 
					client = Wificlient.find_by(id: wlan.client_id)
					client.update(pmk_change: true)
					puts "client ID! : #{client.id}"
				end 
				
			puts "update needed!" 
		else
			puts "update not needed" 
		end 
		
		if  (zone_params[:open_ap] != zone.open_ap and zone_params[:open_ap] != nil)
			Wlan.where( :zone => zone).find_each do |wlan|
					puts "checkpoint 2!" 
					client = Wificlient.find_by(id: wlan.client_id)
					client.update(config_change: true)
					puts "client ID! : #{client.id}"
				end 
		
			puts "update needed!" 
		else
			puts "update not needed" 
		end 
	end
end
