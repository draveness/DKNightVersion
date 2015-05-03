from mod_pbxproj import XcodeProject
import json

project = XcodeProject.Load('../../../DKNightVersion.xcodeproj/project.pbxproj')

project.remove_group_by_name('UIKit', True)

project.save()

main_group = project.get_or_create_group('DKNightVersion')
pod_group = project.get_or_create_group('Pod', None, main_group)
class_group = project.get_or_create_group('Classes', None, pod_group)
uikit_group = project.get_or_create_group('UIKit', None, class_group)

groups = json.load(open('project.json'))

for group, files in groups.iteritems():
    new_group = project.get_or_create_group(group, None, uikit_group)
    for f in files:
        project.add_file(f, new_group)

project.save()
