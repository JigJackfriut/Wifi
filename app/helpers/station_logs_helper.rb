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
		time = [seconds / 3600, seconds / 60 % 60, seconds % 60].map { |t| t.to_s.rjust(2,'0') }.join(':')
	else 
		time = "N/A"
	end 
	
	return time
end



end #end of module
