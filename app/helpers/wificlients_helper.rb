module WificlientsHelper
	def parseWLAN(arr)
		require 'json'
		require 'erb'
		if arr == nil 
			return 
		end 
		stringparse = arr
		b = JSON.parse(stringparse) 
		s=""
		first = true
		b.each do |n|
			wlan = Wlan.where(:id => n)
			n = n.to_s
			s = s + '<%= link_to "'+wlan.name+'", "http://138.28.72.190:3000/wlans/'+n+'" %>'
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



end
