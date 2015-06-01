# -*- coding: utf-8 -*-

require 'fileutils'
require 'erb'
require 'ostruct'

require_relative 'xcodeproj'

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

def objc_code_generator(klasses, p='.')
    groups = {}

	template_folder = File.join('generator', 'lib', 'generator', 'template')
	color_header        = File.join(template_folder, 'color.h.erb')
	color_imp           = File.join(template_folder, 'color.m.erb')
	nightversion_header = File.join(template_folder, 'nightversion.h.erb')
	nightversion_imp    = File.join(template_folder, 'nightversion.m.erb')

	relative_path = File.join('Classes', 'UIKit')
	FileUtils.rm_rf(relative_path)
	FileUtils.mkdir_p(relative_path)
	klasses.each do |klass|
		subfolder_path = File.join(relative_path, klass.name)
		FileUtils.mkdir_p(subfolder_path)

        path = File.join(p, 'Classes', 'UIKit', klass.name)
        groups[klass.name] = []
        groups[klass.name] << File.join(path, klass.nightversion_header_name)
        groups[klass.name] << File.join(path, klass.nightversion_imp_name)

        nightversion_header_file_path = File.join(subfolder_path, klass.nightversion_header_name)
        nightversion_imp_file_path    = File.join(subfolder_path, klass.nightversion_imp_name)
        puts "[Generate] Generating #{nightversion_header_file_path}"
		File.write nightversion_header_file_path, render(nightversion_header, klass)
        puts "[Generate] Generating #{nightversion_imp_file_path}"
		File.write nightversion_imp_file_path,    render(nightversion_imp,    klass)

		klass.properties.each do |property|
			superklass_has_property = has_property(klass.superklass, property.name) if klass.superklass

            groups[klass.name] << File.join(path, klass.color_header_name(property))
            groups[klass.name] << File.join(path, klass.color_imp_name(property))

            color_header_file_path = File.join(subfolder_path, klass.color_header_name(property))
            color_imp_file_path    = File.join(subfolder_path, klass.color_imp_name(property))

            puts "[Generate] Generating #{color_header_file_path}"
            File.write color_header_file_path, render(color_header, klass, property)
            puts "[Generate] Generating #{color_imp_file_path}"
            File.write color_imp_file_path,    render(color_imp,    klass, property)
		end
	end
    groups
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


#table = parse_json('./property.json')
#add_superklass_relation(table)
#handle_method(table)

#pbxproj_file_path = find_pbxproj('.')
#basename = File.basename(find_xcodeproj('.'))
#production = basename.start_with?('Pod')
#path = if production then 'DKNightVersion' else '.' end
#objc_code_generator(table, path)
#group = objc_code_generator(table, path)
#File.write File.join('project', 'project.json'), group.to_json

#json_file_path = 'project/project.json'

#system "python project/project.py #{pbxproj_file_path} #{json_file_path} #{production}"
