# -*- coding: utf-8 -*-

require 'fileutils'
require 'erb'
require 'yaml'
require 'ostruct'
require 'json'

require_relative 'model/objc_property'
require_relative 'model/objc_class'

class ErbalT < OpenStruct
    def self.render_from_hash(t, h)
        ErbalT.new(h).render(t)
    end

    def render(template)
        ERB.new(template).result(binding)
    end
end

def render(template, klass, property=nil)
    erb = File.open(template).read
    if property.nil?
        ErbalT::render_from_hash(erb, { klass: klass })
    else
        ErbalT::render_from_hash(erb, { klass: klass, property: property })
    end
end

def objc_code_generator(klasses)
	template_folder = File.join('.', 'template')
	color_header        = File.join(template_folder, 'color.h.erb')
	color_imp           = File.join(template_folder, 'color.m.erb')
	color_simply_header = File.join(template_folder, 'color_simply.h.erb')
	color_simply_imp    = File.join(template_folder, 'color_simply.m.erb')
	nightversion_header = File.join(template_folder, 'nightversion.h.erb')
	nightversion_imp    = File.join(template_folder, 'nightversion.m.erb')
	
	relative_path = File.join('..', 'Classes', 'UIKit')
	FileUtils.mkdir_p(relative_path)
	klasses.each do |klass|
		subfolder_path = File.join(relative_path, klass.name)
		FileUtils.rm_rf(subfolder_path)
		FileUtils.mkdir_p(subfolder_path)

		File.write File.join(subfolder_path, klass.nightversion_header_name), render(nightversion_header, klass)
		File.write File.join(subfolder_path, klass.nightversion_imp_name),    render(nightversion_imp,    klass)

		klass.properties.each do |property|
			superklass_has_property = has_property(klass.superklass, property.name) if klass.superklass

			if !klass.superklass || !superklass_has_property
				File.write File.join(subfolder_path, klass.color_header_name(property)), render(color_header, klass, property)
				File.write File.join(subfolder_path, klass.color_imp_name(property)),    render(color_imp,    klass, property)
			elsif superklass_has_property
				File.write File.join(subfolder_path, klass.color_header_name(property)), render(color_simply_header, klass, property)
				File.write File.join(subfolder_path, klass.color_imp_name(property)),    render(color_simply_imp,    klass, property)
			end
		end
	end
end

def has_property(klass, name)
    while klass
	    klass.properties.each do |property|
	    	if property.name == name
	    		return property
	    	end
	    end
        klass = klass.superklass
    end
	return nil
end

def is_superklass(superklass, subklass)
    superklass_json = JSON.parse File.read('json/superklass.json')
    subklass_list = superklass_json[superklass]
    if subklass_list
        if subklass_list.find_index(subklass)
            return true
        else
            subklass_list.inject(false) do |memo, sub| memo || is_superklass(sub, subklass) end
        end
    else
        return false
    end
end


def parse_json(file)
    property_json = JSON.parse File.read(file)
    property_json.map do |klass, colors|
        ObjcClass.new(klass, colors.map { |color, value| ObjcProperty.new(name: color, default_color: value) })
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
    method_json = JSON.parse File.read('json/method.json')
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


table = parse_json('property.json')
add_superklass_relation(table)
handle_method(table)

objc_code_generator(table)
