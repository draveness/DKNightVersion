require 'xcodeproj'
require 'json'

def add_files_to_project(path, json_path)
    production = File.basename(path).start_with?('Pod')
    json = JSON.parse File.read(json_path)
    project = Xcodeproj::Project.open(path)
    target = get_target(project, production)

    group_path = get_group_name(production)
    uikit_group = project.main_group.find_subpath(group_path, true)
    uikit_group.clear
    uikit_group.set_source_tree('SOURCE_ROOT')
    clear_target(target)

    file_refs = []
    json.each do |f|
        unless uikit_group.find_file_by_path(f)
            file_ref = uikit_group.new_reference(f)
            file_refs << file_ref
        end
    end

    target.add_file_references(file_refs)

    project.save
end


def get_target(project, production)
    if production
        project.targets.reduce(project.targets.first) do |init, t| 
            puts "[Find] Find target #{t}"
            if t.to_s.include? 'DKNightVersion' 
                init = t
            end
        end
    else 
        project.targets.first
    end
end

def get_group_name(production)
    if production 
        'Pods/DKNightVersion/UIKit' 
    else
        'DKNightVersion/Pod/Classes/UIKit'
    end
end

def should_remove(file_name)
    return false if file_name.match('UIButton') or file_name.match('UIImageView')
    /UI[a-zA-Z]+\+(?:[a-zA-Z]+?|Night)\.[hm]/.match(file_name)
end

def clear_target(target)
    target.source_build_phase.files_references.each do |file_ref|
        if file_ref != nil && should_remove(file_ref.name)
            target.source_build_phase.remove_file_reference(file_ref)
        end
    end
    target.headers_build_phase.files_references.each do |file_ref|
        if file_ref != nil && should_remove(file_ref.name)
            target.headers_build_phase.remove_file_reference(file_ref)
        end
    end
end
