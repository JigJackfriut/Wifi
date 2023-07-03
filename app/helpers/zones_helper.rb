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
		if (zone_params[:ssid] != zone.ssid) or (zone_params[:open] != zone.open) 
			client = Wificlient.find_by(id: zone.client_id)
			client.update(update_needed: true)
			puts "update needed!" 
		else
			puts "update not needed!" 
		end 
	end
end
