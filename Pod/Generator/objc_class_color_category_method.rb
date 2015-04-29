# -*- coding: utf-8 -*-

module ObjcClassColorCategoryMethod

	def method_string
		<<-OBJECT_C
#{hook_method_string}
#{dynamic_property_string}
		OBJECT_C
	end


	def hook_method_string
		<<-OBJECT_C
#pragma mark - Hook

#{method_swizzling_string}
- (void)hook_set#{cap_name}:(#{type} *)#{name} #{method} {
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNormal) {
        [self setNormal#{cap_name}:#{name}];
    }
    [self hook_set#{cap_name}:#{name}#{selector_name}#{parameter}];
}
		OBJECT_C
	end


	def method_swizzling_string
		<<-OBJECT_C
+ (void)load {
    static dispatch_once_t onceToken;                                              
    dispatch_once(&onceToken, ^{                                                   
        Class class = [self class];                                                
        SEL originalSelector = @selector(set#{cap_name}:#{selector_name});                                  
        SEL swizzledSelector = @selector(hook_set#{cap_name}:#{selector_name});                                 
        Method originalMethod = class_getInstanceMethod(class, originalSelector);  
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);  
        BOOL didAddMethod =                                                        
        class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));                   
        if (didAddMethod){
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));           
        } else {                                                                   
            method_exchangeImplementations(originalMethod, swizzledMethod);        
        }
    });
}
		OBJECT_C
	end

	def dynamic_property_string
		<<-OBJECT_C
#pragma mark - #{cap_name}

- (#{type} *)normal#{cap_name} {
    return objc_getAssociatedObject(self, &normal#{cap_name}Key);
}

- (void)setNormal#{cap_name}:(#{type} *)normal#{cap_name} {
    objc_setAssociatedObject(self, &normal#{cap_name}Key, normal#{cap_name}, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (#{type} *)night#{cap_name} {
    return objc_getAssociatedObject(self, &night#{cap_name}Key) ? : self.#{getter || name};
}

- (void)setNight#{cap_name}:(#{type} *)night#{cap_name} {
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
        [self set#{cap_name}:night#{cap_name}#{selector_name}#{parameter}];
    }
    objc_setAssociatedObject(self, &night#{cap_name}Key, night#{cap_name}, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
		OBJECT_C
	end

end
