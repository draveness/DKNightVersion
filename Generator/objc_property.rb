class ObjcProperty
	attr_accessor :name
	attr_accessor :type
	attr_reader   :cap_name

	def initialize(name)
		@name = name
		@type = "UIColor"
	end

	def method_string
		s = <<H
#{hook_method_string}
#{dynamic_property_string}
H
	end

	def cap_name
		@name[0].upcase + @name[1..-1]
	end

private

	def hook_method_string
		s = <<H
#pragma mark - Hook

#{method_swizzling_string}
- (void)hook_set#{cap_name}:(#{type} *)#{name} {
    self.normal#{cap_name} = #{name};
   [self hook_set#{cap_name}:#{name}];
}
H
	end


	def method_swizzling_string
		s = <<H
+ (void)load {
    static dispatch_once_t onceToken;                                              
    dispatch_once(&onceToken, ^{                                                   
        Class class = [self class];                                                
        SEL originalSelector = @selector(set#{cap_name}:);                                  
        SEL swizzledSelector = @selector(hook_set#{cap_name}:);                                 
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
H
	end

	def dynamic_property_string
		s = <<H
#pragma mark - #{cap_name}

- (#{type} *)normal#{cap_name} {
    return objc_getAssociatedObject(self, &normal#{cap_name}Key);
}

- (void)setNormal#{cap_name}:(#{type} *)normal#{cap_name} {
    objc_setAssociatedObject(self, &normal#{cap_name}Key, normal#{cap_name}, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (#{type} *)night#{cap_name} {
    return objc_getAssociatedObject(self, &night#{cap_name}Key) ? : self.#{name};
}

- (void)setNight#{cap_name}:(#{type} *)night#{cap_name} {
    objc_setAssociatedObject(self, &night#{cap_name}Key, night#{cap_name}, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
H
	end

end