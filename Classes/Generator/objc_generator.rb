require './objc_property'
require './objc_class'
require 'fileutils'
require 'yaml'


def objc_code_generator(table)
	table.each do |cls|
		relative_path =  "../UIKit"
		subfolder_path = relative_path + '/' + cls.name + '/'

		FileUtils.mkdir_p(relative_path)
		FileUtils.mkdir_p(relative_path + "/#{cls.name}")
		File.open(relative_path + '/' + cls.night_header_file_name, "w+") do |f|
			f.write(cls.night_interface_string)
		end
		File.open(relative_path + '/' + cls.night_file_name + '.m', "w+") do |f|
			f.write(cls.night_implementation_string)
		end
		cls.properties.each do |property|
			File.open(subfolder_path + cls.header_file_name(property), "w+") do |f|
				f.write(cls.interface_class_string(property))
			end
			File.open(subfolder_path + cls.file_name(property) + '.m', "w+") do |f|
				f.write(cls.implementation_class_string(property))
			end
		end
	end
end

def parse_yaml(file)
	yaml = YAML.load_file(file)
	table = []
	yaml.each do |cls, hash|
		objc_class = ObjcClass.new(cls.to_s, hash["superclass"])
		hash["properies"].each do |property|
			objc_property = ObjcProperty.new(property.to_s)
			objc_class.properties << objc_property
		end
		table << objc_class
	end
	table
end

table = parse_yaml('property_table.yaml')
# puts table[1].night_implementation_string
objc_code_generator(table)

