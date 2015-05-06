require 'xcodeproj'
require 'json'

def add_files_to_project(path, json_path)
    production = File.basename(path).start_with?('Pod')
    j = JSON.parse File.read(json_path)
    project = Xcodeproj::Project.open(path)
    target = if production
                 project.targets.reduce(project.targets.first) do |init, t| 
                     if t.to_s.include? 'DKNightVersion' 
                         init = t
                     end
                 end
             else 
                 project.targets.first
             end
    
    group_path = if production 
                     'Pods/DKNightVersion/UIKit' 
                 else
                     'DKNightVersion/Pod/Classes/UIKit'
                 end
    j.each do |group, files|
        new_group = project.main_group.find_subpath(File.join(group_path, group), true)
        new_group.set_source_tree('SOURCE_ROOT')
        file_refs = []
        files.each do |f|
            unless new_group.find_file_by_path(f) 
                file_ref = new_group.new_reference(f)
                file_refs << file_ref
            end
        end
        file_refs.each do |file_ref|
            unless target.resources_build_phase.files_references.include?(file_ref)
              target.add_file_references([file_ref])
            end
        end
        
    end
    project.save
end


