# -*- coding: utf-8 -*-

require_relative 'objc_class_color_category_method'

class ObjcProperty
	include ObjcClassColorCategoryMethod

	attr_accessor :name, :type

	def initialize(name, type = "UIColor")
		@name = name
		@type = type
	end
	
	def cap_name
		@name[0].upcase + @name[1..-1]
	end
end