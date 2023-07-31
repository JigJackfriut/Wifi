module StationLogsHelper
class Array
	def to_activerecord_relation
    return ApplicationRecord.none if self.empty?

    clazzes = self.collect(&:class).uniq
    raise 'Array cannot be converted to ActiveRecord::Relation since it does not have same elements' if clazzes.size > 1

    clazz = clazzes.first
    raise 'Element class is not ApplicationRecord and as such cannot be converted' unless clazz.ancestors.include? ApplicationRecord

    clazz.where(id: self.collect(&:id))
  	end
  
end

def secondsToTime(connectedTime)

	if !connectedTime.nil?
		arrayString = connectedTime.split(" ")
		seconds = arrayString[0].to_i
		time = [seconds / 86400 ,(seconds - (seconds / 86400 ) * 86400) / 3600, seconds / 60 % 60, seconds % 60].map { |t| t.to_s.rjust(2,'0') }.join(':')
	end 
	return time
end

def bytes_conversion(bytes)
if bytes != nil
   s = ""
		if (bytes /1073741824) != 0
      		gigabytes = (bytes / 1073741824).round(2)
      		s = s + gigabytes.to_s + " GB"
		elsif (bytes / 1048576) != 0
      		megabytes = (bytes / 1048576).round(2)
			s = s + megabytes.to_s + " MB"
		elsif (bytes / 1024).floor != 0
			kilobytes = (bytes / 1024).round(2)
			s = s + kilobytes.to_s + " KB"
		elsif (bytes/1024) == 0
			s = s + bytes.to_s + " Bytes"
  end
	return s
end
end

end #end of module
