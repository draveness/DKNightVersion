from mod_pbxproj import XcodeProject
import json
import sys

def to_bool(value):
    valid = {'true': True, 't': True, '1': True,
            'false': False, 'f': False, '0': False,
            }
    if isinstance(value, bool):
        return value
    if not isinstance(value, basestring):
        raise ValueError('invalid literal for boolean. Not a string.')
    lower_value = value.lower()
    if lower_value in valid:
        return valid[lower_value]
    else:
        raise ValueError('invalid literal for boolean: "%s"' % value)


pbxproj_file_path = sys.argv[1]
json_file_path = sys.argv[2]
production = to_bool(sys.argv[3])

project = XcodeProject.Load(pbxproj_file_path)
project.remove_group_by_name('UIKit', True)
project.save()

if production == False:
    if production:
        main_group = project.get_groups_by_name('DKNightVersion')[0]
        uikit_group = project.get_or_create_group('UIKit', None, main_group)
    else:
        main_group = project.get_or_create_group('DKNightVersion')
        pod_group = project.get_or_create_group('Pod', None, main_group)
        class_group = project.get_or_create_group('Classes', None, pod_group)
        uikit_group = project.get_or_create_group('UIKit', None, class_group)

    groups = json.load(open(json_file_path))

    for group, files in groups.iteritems():
        new_group = project.get_or_create_group(group, None, uikit_group)
        for f in files:
            project.add_file(f, new_group)

    project.save()
