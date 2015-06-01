# -*- coding: utf-8 -*-

class ObjcProperty
	attr_accessor :name, :type, :getter, :setter, :parameter

	def initialize args
        args.each do |k,v|
           instance_variable_set("@#{k}", v) unless v.nil?
        end
        @type   ||= "UIColor *"
		@setter ||= "set#{cap_name}:(UIColor*)#{name}"
		@getter ||= "#{name}"
  	end
	
	def cap_name
		@name[0].upcase + @name[1..-1]
	end

	def setter_selector_name
		setter.split().map { |s| (/.*:/).match(s).to_s }.join
	end
	
	def set_color_method(color)
		s = setter.split(' ').map { |str| (/.*:/).match(str).to_s }
		s.first.concat(color)
		s[1].concat(parameter) unless parameter.nil?
		s.join(' ')
	end

end
