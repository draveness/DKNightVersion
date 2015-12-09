require 'colorize'
require 'fileutils'

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
    files = objc_code_generator(table, path)
    json_file_path = File.join('generator', 'lib', 'generator', 'json', 'project.json')
    File.write json_file_path, files.to_json

    puts "[Link] Find pbxproj file path".yellow
    puts "[Link] pbxproj is at '#{xcode_proj_file}'".green
    puts "[Link] Linking to xcodeproj".yellow
    add_files_to_project(xcode_proj_file, json_file_path)

    # remove null source files in project.pbxproj
    puts "[Link] Refine project.pbxproj file".yellow
    output_file = 'tmp'
    input_file = File.join(xcode_proj_file, "project.pbxproj")
    File.open(output_file, "w") do |out_file|
        File.foreach(input_file) do |line|
            out_file.puts line unless line.match("(null)")
        end
    end

    FileUtils.mv(output_file, input_file)

    puts "[DKNightVersion] has already generate all files".green
end
