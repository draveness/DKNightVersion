require './objc_property'
require './objc_class'
require 'fileutils'
require 'yaml'

def objc_code_generator(table)
	table.each do |cls|
		FileUtils.mkdir_p('UIKit')
		FileUtils.mkdir_p("UIKit/#{cls.name}")
		cls.properties.each do |property|
			File.open('UIKit/' + cls.name + '/' + cls.file_name(property) + '.h', "w+") do |f|
				f.write(cls.interface_class_string(property))
			end
			File.open('UIKit/' + cls.name + '/' + cls.file_name(property) + '.m', "w+") do |f|
				f.write(cls.implementation_class_string(property))
			end
		end
	end
end

def parse_yaml(file)
	yaml = YAML.load_file(file)

	table = []
	yaml.each do |cls, properties|
		objc_class = ObjcClass.new(cls.to_s)
		properties.each do |property|
			objc_property = ObjcProperty.new(property.to_s)
			objc_class.properties << objc_property
		end
		table << objc_class
	end
	table
end

table = parse_yaml('property.yaml')
objc_code_generator(table)