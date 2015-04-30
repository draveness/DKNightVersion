# -*- coding: utf-8 -*-

class ObjcClass
	attr_accessor :name, :properties

	def initialize(name, properties = [])
		@name = name
		@properties = properties
	end

	def nightversion_header_name
		name + '+NightVersion.h'
	end

	def nightversion_imp_name
		name + '+NightVersion.m'
	end

	def color_header_name(property)
		file_name(property) + '.h'
	end
	
	def color_imp_name(property)
		file_name(property) + '.m'
	end

private

	def file_name(property)
		"#{name}+#{property.cap_name}"
	end
end
