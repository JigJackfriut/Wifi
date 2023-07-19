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
end
