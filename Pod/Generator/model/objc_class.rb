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

	def file_name(property)
		"#{name}+#{property.cap_name}"
	end

end
