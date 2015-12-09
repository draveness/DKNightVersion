# -*- coding: utf-8 -*-

class ObjcClass
	attr_accessor :name, :properties, :superklass
    attr_reader :all_properties, :superklass_name

	#def initialize(name, superklass_name, properties = [])
	#	@name = name
    #    @superklass_name = superklass_name
    #    @properties = properties
	#end
	def initialize(name, properties = [])
		@name = name
        @properties = properties
	end

    def header_name
        "#{name}+Night.h"
    end

    def imp_name
        "#{name}+Night.m"
    end

    def all_properties
        p = properties.dup
        name = p.map { |property| property.name }
        k = superklass
        while k
            superklass.properties.each do |property|
                p << property if !name.find_index(property.name)
            end
            k = k.superklass
            name = p.map { |property| property.name }
        end
        p.uniq
    end

    def superklass_name
        if superklass
            superklass.name
        else
            nil
        end
    end


    def all_superklass_name
        k = []
        return if !superklass_name
        s = superklass
        while s
            k << s.name
            s = s.superklass
        end
        k
    end

private

end
