# -*- coding: utf-8 -*-

require 'fileutils'
require 'yaml'

require_relative 'objc_property'
require_relative 'objc_class'

def objc_code_generator(klasses)
	relative_path = File.join('..', 'Classes', 'UIKit', 'Auto')
	FileUtils.mkdir_p(relative_path)
	klasses.each do |klass|
		subfolder_path = File.join(relative_path, klass.name)
		FileUtils.mkdir_p(subfolder_path)

		File.write File.join(subfolder_path, klass.night_header_file_name), klass.night_interface_string
		File.write File.join(subfolder_path, klass.night_file_name + '.m'), klass.night_implementation_string

		klass.properties.each do |property|
			File.write File.join(subfolder_path, klass.header_file_name(property)), klass.interface_class_string(property)
			File.write File.join(subfolder_path, klass.file_name(property) + '.m'), klass.implementation_class_string(property)
		end
	end
end

def parse_yaml(file)
	YAML.load_file(file).map do |klass, config|
		ObjcClass.new(klass.to_s, config["superclass"], config["properties"].map { |property| ObjcProperty.new(property.to_s) })
	end
end

table = parse_yaml('property_table.yaml')
# puts table[1].night_implementation_string
objc_code_generator(table)

