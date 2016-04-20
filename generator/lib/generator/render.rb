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
    groups = []

    template_folder = File.join('generator', 'lib', 'generator', 'template')
    color_header        = File.join(template_folder, 'color.h.erb')
    color_imp           = File.join(template_folder, 'color.m.erb')

    relative_path = File.join('DKNightVersion', 'UIKit')
    FileUtils.rm_rf(relative_path)
    FileUtils.mkdir_p(relative_path)
    klasses.each do |klass|
        groups << File.join(relative_path, klass.header_name)
        groups << File.join(relative_path, klass.imp_name)

        header_file_path = File.join(relative_path, klass.header_name)
        imp_file_path    = File.join(relative_path, klass.imp_name)

        puts "[Generate] Generating #{header_file_path}"
        File.write header_file_path, render(color_header, klass)
        puts "[Generate] Generating #{imp_file_path}"
        File.write imp_file_path,    render(color_imp,    klass)
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


