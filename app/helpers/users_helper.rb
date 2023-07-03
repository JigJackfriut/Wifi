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
			client = Wificlient.find_by(id: user.client_id)
			client.update(update_needed: true)
			puts "update needed!" 
		else
			puts "update not needed!" 
		end 
	end
end
