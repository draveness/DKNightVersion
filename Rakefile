require_relative 'generator/lib/generator'
task :default do
    puts "[Parse] Parsing JSON"
    table = parse_json('property.json')
    puts "[Parse] Add superclass relation"
    add_superklass_relation(table)
    puts "[Parse] Fix method setter and getter"
    handle_method(table)
    pbxproj_file_path = find_pbxproj('.')
    basename = File.basename(find_xcodeproj('.'))
    production = basename.start_with?('Pod')
    puts "[Generate] Start to generates UIKit files"
    path = if production then 'DKNightVersion' else '.' end
    group = objc_code_generator(table, path)
    File.write File.join('generator', 'lib', 'generator', 'project', 'project.json'), group.to_json

    json_file_path = File.join('generator', 'lib', 'generator', 'project', 'project.json')
    python_file = File.join('generator', 'lib', 'generator', 'project', 'project.py')
    puts "[Link] Find pbxproj file path"
    puts "       pbxproj is at '#{pbxproj_file_path}'"
    puts "[Link] Linking to xcodeproj"
    system "python #{python_file} #{pbxproj_file_path} #{json_file_path} #{production}"
    puts "[DKNightVersion] has already all files for you!"
end
