require 'colorize'

require_relative 'generator/lib/generator'

task :default do
    puts "[Parse] Parsing JSON".yellow
    table = parse_json('property.json')
    puts "[Parse] Add superclass relation".green
    add_superklass_relation(table)
    puts "[Parse] Fix method setter and getter".green
    handle_method(table)
    pbxproj_file_path = find_pbxproj('.')
    basename = File.basename(find_xcodeproj('.'))
    production = basename.start_with?('Pod')
    puts "[Generate] Start to generates UIKit files".yellow
    path = if production then 'DKNightVersion' else '.' end
    group = objc_code_generator(table, path)
    File.write File.join('generator', 'lib', 'generator', 'project', 'project.json'), group.to_json

    json_file_path = File.join('generator', 'lib', 'generator', 'project', 'project.json')
    python_file = File.join('generator', 'lib', 'generator', 'project', 'project.py')
    puts "[Link] Find pbxproj file path".yellow
    puts "[Link] pbxproj is at '#{pbxproj_file_path}'".green
    puts "[Link] Linking to xcodeproj".yellow
    system "python #{python_file} #{pbxproj_file_path} #{json_file_path} #{production}"

    puts "[DKNightVersion] has already generate all files for you!".green
    puts
    puts
    puts "    You are supposed to drag files just generated to your workspace".yellow
    puts "    If you don't know how to do that, click https://github.com/Draveness/DKNightVersion and follow the tutorial"
    puts
end
