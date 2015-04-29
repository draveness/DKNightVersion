# -*- coding: utf-8 -*-

require_relative 'objc_class_color_category_method'

class ObjcProperty
	include ObjcClassColorCategoryMethod

	attr_accessor :name, :type, :getter, :method, :parameter

	def initialize args
        args.each do |k,v|
           instance_variable_set("@#{k}", v) unless v.nil?
        end
        @type = "UIColor"
  	end
	
	def cap_name
		@name[0].upcase + @name[1..-1]
	end

	def selector_name
		if /.*:/.match(method).to_s.empty?
			""
		else
            " " + /.*:/.match(method).to_s
		end
	end
end