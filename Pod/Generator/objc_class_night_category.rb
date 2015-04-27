module ObjcClassNightCategory

	def night_interface_string
		s = <<H
//
//  #{name}+NightVersion.h
//  #{name}+NightVersion
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import <UIKit/UIKit.h>
#{night_interface_import_string}
@interface #{name} (NightVersion)

- (void)switchColor;

@end
H
	end

	def night_interface_import_string
		s = ""
		properties.each do |property|
			s = s + "#import \"" + name + "+#{property.cap_name}.h\"\n"
		end
		s
	end

	def night_implementation_string
		s = <<H
//
//  #{name}+NightVersion.m
//  #{name}+NightVersion
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import "#{name}+NightVersion.h"
#{night_implementation_superclass_string}
#import "DKNightVersionManager.h"
#import "DKNightVersionConstants.h"

@implementation #{name} (NightVersion)

#pragma mark - SwitchColor

- (void)switchColor {
    #{night_implementation_method_string}[UIView animateWithDuration:NIGHT_ANIMATION_DURATION animations:^{
        #{night_implementation_property_string}
    }];
}

@end
H
	end

	def night_implementation_superclass_string
		s = superclass ? "#import \"#{superclass}+NightVersion.h\"" : ""
	end

	def night_implementation_method_string
		if superclass
			super_string = "[super switchColor];\n    " 
		else
			super_string = ""
		end
	end

	def night_implementation_property_string
		s = ""
		properties.each do |property|
			s = s + "self.#{property.name} = ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? \
self.night#{property.cap_name} : self.normal#{property.cap_name};"
		end
		s
	end

end