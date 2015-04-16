require "./objc_class_color_category_method.rb"

class ObjcProperty
	include ObjcClassColorCategoryMethod

	attr_accessor :name
	attr_accessor :type
	attr_reader   :cap_name

	def initialize(name)
		@name = name
		@type = "UIColor"
	end
	
	def cap_name
		@name[0].upcase + @name[1..-1]
	end

end