module WificlientsHelper
	def parseWLAN(wificlient)
		s=""
		first = true
		Wlan.where(:client_id => wificlient.id).find_each do |wlan|
			wlanName = wlan.name 
			puts "HERE IT IS!!! #{wlan.name}"
			n = (wlan.id).to_s						
			s = s + '<%= link_to "'+ wlanName +'", "/wlans/'+n+'" %> </br>' 
			#s = s + '<input type = "checkbox" id="' + n +'" name="' +n +'" value="Bike"> <label for="' + n +'">' + n +'</label><br>'
			first=false
		end 
		puts "Result: #{s}"
		
		#<%= link_to wlan_path(wlan), data: {turbo_method: :delete, }, style: "text-decoration:none" %>
		
		#return s 
		#return '<input type="checkbox" id="vehicle1" name="vehicle1" value="Bike"> <label for="vehicle1"> I have a bike</label><br>'.html_safe
		#return s.html_safe
		
		html = ERB.new(s).result(binding)
		
		return html.html_safe
		
	end
	
	def wificlientUpdate(wificlient, wificlient_params)
	puts "we are in"                                                                                          
	if (wificlient_params[:enabled] != wificlient.enabled and wificlient_params[:enabled]!=nil) or (wificlient_params[:wlan_name] != wificlient.wlan_name) or (wificlient_params[:country] != wificlient.country)
	wificlient.update(update_needed: true)
	puts "UUUUUUUUUUUUUUUUUUUUUUUUUUpdate needed!"
	else
	puts "update not needed!"
	end	
	end
end
