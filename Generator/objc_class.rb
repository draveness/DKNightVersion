require "./objc_class_color_category.rb"
require "./objc_class_night_category.rb"

class ObjcClass
	include ObjcClassColorCategory
	include ObjcClassNightCategory

	attr_accessor :name
	attr_accessor :properties
	attr_accessor :superclass

	def initialize(name, superclass)
		@name = name
		@superclass = superclass
		@properties = []
	end

	def night_header_file_name
		name + '+NightVersion.h' 
	end

	def night_file_name
		name + '+NightVersion' 
	end

	def header_file_name(property)
		file_name(property) + '.h'
	end

	def file_name(property)
		s = "#{name}+#{property.cap_name}"
	end
end
