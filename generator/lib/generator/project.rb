require 'xcodeproj'
require 'json'

def add_files_to_project(path, json_path)
    j = JSON.parse File.read(json_path)
    project = Xcodeproj::Project.open(path)
    target = project.targets.first
    
    group_path = 'DKNightVersion/Pod/Classes/UIKit'
    j.each do |group, files|
        new_group = project.main_group.find_subpath(File.join(group_path, group), true)
        file_refs = []
        files.each do |f|
            unless new_group.find_file_by_path(f) 
                file_ref = new_group.new_reference(f)
                file_refs << file_ref
            end
        end
        target.add_file_references(file_refs)
        puts target.source_build_phase.files.first.inspect
    end
    project.save
end


