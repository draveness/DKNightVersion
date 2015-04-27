# -*- coding: utf-8 -*-

require_relative 'objc_class_color_category'
require_relative 'objc_class_night_category'

class ObjcClass
	include ObjcClassColorCategory, ObjcClassNightCategory

	attr_accessor :name, :properties, :superclass

	def initialize(name, superclass, properties = [])
		@name = name
		@superclass = superclass
		@properties = properties
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
		"#{name}+#{property.cap_name}"
	end
end