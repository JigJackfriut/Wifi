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
end
