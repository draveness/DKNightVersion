require 'xcodeproj'
require 'json'

def extract_children_by_name(group, name)
    group.children.each do |child|
        if child.path == name
            puts child.inspect
            return child
        end
    end
end
path = 'DKNightVersion/Pod/Classes/UIKit/'
j = JSON.parse File.read('./project.json')
project = Xcodeproj::Project.open('DKNightVersion.xcodeproj')

#uikit_group = project.main_group.find_subpath(path, true)

j.each do |group, files|
    new_group = project.main_group.find_subpath(File.join(path, group), true)
    files.each do |f|
        puts f
        new_group.new_file(f)
    end
end

#uikit_group.new_reference('UIKit/UIButton/UIButton+NightVersion.h')

project.save


