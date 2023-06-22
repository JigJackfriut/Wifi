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
end
