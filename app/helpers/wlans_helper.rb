module WlansHelper
	def parseArray(arr)
		if arr == nil 
			return 
		end 
		stringparse = arr
		b = JSON.parse(stringparse) 
		s=""
		first = true
		b.each do |n|
			if not first
				s=s+", "
			end 
			s=s+n 
			first=false
		end 
		puts "Result: #{s}"
		return s 
  end
  
  
  def parseWifiClient(arr)
		require 'erb'
		if arr == nil 
			return 
		end 
		s=""
		client = Wificlient.find_by(:id => arr).name
		puts "SHOW: #{client}"
		client = client.to_s
		arr = arr.to_s
		
		s = s + '<%= link_to "'+ client +'", "/wificlients/'+arr+'" %> </br>' 
		puts "Result: #{s}"
		html = ERB.new(s).result(binding)
		
		return html.html_safe
		
	end
	
	def parseChannels(arr)
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
	
	def parseZone(arr)
		require 'erb'
		if arr == nil 
			return 
		end 
		s=""
		zone = Zone.find_by(:id => arr).name
		puts "SHOW: #{zone}"
		zone = zone.to_s
		s = s + '<%= link_to "'+ zone +'", "/zones/'+arr+'" %> </br>' 
		puts "RESULT: #{s}"
		html = ERB.new(s).result(binding)
		
		return html.html_safe
	end
	
	def parseA(arr)
		if arr == nil 
			return 
		end 
		#stringparse = arr
		#b = JSON.parse(stringparse) 
		s= [] 
		arr.each do |n|
			if n.to_i <= 169 and n.to_i >= 36
				s.append(n)
			end
		end 
		puts "Result: #{s}"
		return s 
	
	end
	
	
	def wlanUpdate(wlan, wlan_params)
	  if !wlan.client_id.nil?
		if ((wlan_params[:enabled] != wlan.enabled and wlan_params[:enabled]!=nil) or (wlan_params[:mode] != wlan.mode and wlan_params[:mode]!=nil))
			puts "params: #{wlan_params[:enabled]} old: #{wlan.enabled}"
			puts "params: #{wlan_params[:mode]} old: #{wlan.mode}"
			puts "wlan id! #{wlan.id} client id! #{wlan.client_id}"
			client = Wificlient.find_by(id: wlan.client_id)
			client.update(config_change: true)
			puts "update needed!" 
		else
			puts "update not needed!" 
		end 
		
		if ((wlan_params[:selected_g]!= parseChannels(wlan.selected_g) and wlan_params[:selected_g] !=nil ) or (wlan_params[:selected_a]!= parseChannels(wlan.selected_a) and wlan_params[:selected_a] !=nil))
			puts "TESTING G IF NEW EQUALS OLD #{wlan_params[:selected_g]!= parseChannels(wlan.selected_g)}, TESTING G IF NIL #{wlan_params[:selected_g]==nil}"
			puts "params: #{wlan_params[:selected_g]} old: #{parseChannels(wlan.selected_g)}"
			puts "params: #{wlan_params[:selected_a]} old: #{wlan.selected_a}"
			puts "update needed!" 
			client = Wificlient.find_by(id: wlan.client_id)
			client.update(config_change: true)
		else
			puts "update not needed!"
		end
	end 
	end 
end
