require 'colorize'

require_relative 'generator/lib/generator'

task :default do
    puts "[Parse] Parsing JSON".yellow
    table = parse_json('property.json')
    puts "[Parse] Add superclass relation".green
    add_superklass_relation(table)
    puts "[Parse] Fix method setter and getter".green
    handle_method(table)
    xcode_proj_file = find_xcodeproj('.')
    basename = File.basename(xcode_proj_file)
    production = basename.start_with?('Pod')
    puts "[Generate] Start to generates UIKit files".yellow
    path = if production then 'DKNightVersion' else '.' end
    group = objc_code_generator(table, path)
    json_file_path = File.join('generator', 'lib', 'generator', 'json', 'project.json')
    File.write json_file_path, group.to_json

    #python_file = File.join('generator', 'lib', 'generator', 'project', 'project.py')
    puts "[Link] Find pbxproj file path".yellow
    puts "[Link] pbxproj is at '#{xcode_proj_file}'".green
    puts "[Link] Linking to xcodeproj".yellow
    add_files_to_project(xcode_proj_file, json_file_path)

    puts "[DKNightVersion] has already generate all files for you!".green
    #puts
    #puts
    #puts "    You are supposed to drag files just generated to your workspace".yellow
    #puts "    If you don't know how to do that, goto https://github.com/Draveness/DKNightVersion and follow the tutorial"
    #puts
end
