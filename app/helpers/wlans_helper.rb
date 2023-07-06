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
		client = Wificlient.find_by(:name => arr).id
		puts "SHOW: #{client}"
		client = client.to_s
		s = s + '<%= link_to "'+ arr +'", "/wificlients/'+client+'" %> </br>' 
			#s = s + '<input type = "checkbox" id="' + n +'" name="' +n +'" value="Bike"> <label for="' + n +'">' + n +'</label><br>'
		puts "Result: #{s}"
		
		#<%= link_to wlan_path(wlan), data: {turbo_method: :delete, }, style: "text-decoration:none" %>
		
		#return s 
		#return '<input type="checkbox" id="vehicle1" name="vehicle1" value="Bike"> <label for="vehicle1"> I have a bike</label><br>'.html_safe
		#return s.html_safe
		
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
	
	def wlanUpdate(wlan, wlan_params)
	
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
