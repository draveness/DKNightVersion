require 'json'

require_relative 'model/objc_property'
require_relative 'model/objc_class'

def parse_json(file)
    property_json = JSON.parse File.read(file)
    property_json.map do |klass, properties|
        ObjcClass.new(klass, properties.map { |property| ObjcProperty.new(name: property) })
    end
end

def add_superklass_relation(table)
    table.each do |first_klass|
        table.each do |second_klass|
            if is_superklass(first_klass.name, second_klass.name)
                # subklass's superklass property is nil or the new superklass is more closer than
                # original one.
                second_klass.superklass = first_klass if second_klass.superklass.nil? || 
                    is_superklass(second_klass.superklass.name, first_klass.name)
            end
        end
    end
    table
end

def handle_method(table)
    method_json = JSON.parse File.read('generator/lib/generator/json/method.json')
    table.each do |klass|
        if method_json[klass.name]
            klass.properties.each do |property|
                if method_json[klass.name][property.name]
                    property_json = method_json[klass.name][property.name]
                    property.getter    = property_json['getter']
                    property.setter    = property_json['setter']
                    property.parameter = property_json['parameter']
                end
            end
        end
    end
end

def is_superklass(superklass, subklass)
    superklass_json = JSON.parse File.read('generator/lib/generator/json/superklass.json')
    subklass_list = superklass_json[superklass]
    if subklass_list
        if subklass_list.find_index(subklass)
            return true
        else
            subklass_list.inject(false) do |memo, sub|
                memo || is_superklass(sub, subklass) 
            end
        end
    else
        return false
    end
end
