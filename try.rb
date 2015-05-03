require 'xcodeproj'

proj = Xcodeproj::Project.new('DKNightVersion.xcodeproj')
implm_ref = proj.main_group.new_file('./guess.m')
app_target = proj.targets.first
app_target.add_file_references([implm_ref])

proj.save
