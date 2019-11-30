//
//  NSObject+HRuntime.m
//  DZNEmptyDataSet
//
//  Created by Jvaeyhcd on 2019/8/28.
//

#import "NSObject+HRuntime.h"

@implementation NSObject (HRuntime)

- (NSArray *)propertiesList {
    return [[self class] propertiesList];
}

+ (NSArray *)propertiesList {
    
    NSMutableArray *propertieArray = [NSMutableArray array];
    
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    for (int i = 0; i < propertyCount; i++)
    {
        [propertieArray addObject:({
            
            NSDictionary *dictionary = [self dictionaryWithProperty:properties[i]];
            
            dictionary;
        })];
    }
    
    free(properties);
    
    return propertieArray;
}

+ (NSDictionary *)dictionaryWithProperty:(objc_property_t)property {
    
    NSMutableDictionary *res = [NSMutableDictionary dictionary];
    
    // name
    NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
    [res setObject:propertyName forKey:@"name"];
    
    // attribute
    NSMutableDictionary *attributeDictionary = ({
        
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        
        unsigned int attributeCount;
        objc_property_attribute_t *attrs = property_copyAttributeList(property, &attributeCount);
        
        for (int i = 0; i < attributeCount; i++) {
            NSString *name = [NSString stringWithCString:attrs[i].name encoding:NSUTF8StringEncoding];
            NSString *value = [NSString stringWithCString:attrs[i].value encoding:NSUTF8StringEncoding];
            [dictionary setObject:value forKey:name];
        }
        
        free(attrs);
        
        dictionary;
    });
    
    NSMutableArray *attributeArray = [NSMutableArray array];
    if ([attributeDictionary objectForKey:@"R"]) {
        [attributeArray addObject:@"readonly"];
    }
    if ([attributeDictionary objectForKey:@"C"]) {
        [attributeArray addObject:@"copy"];
    }
    if ([attributeDictionary objectForKey:@"&"]) {
        [attributeArray addObject:@"strong"];
    }
    if ([attributeDictionary objectForKey:@"N"]) {
        [attributeArray addObject:@"nonatomic"];
    } else {
        [attributeArray addObject:@"atomic"];
    }
    if ([attributeDictionary objectForKey:@"G"]) {
        [attributeArray addObject:[NSString stringWithFormat:@"getter=%@", [attributeDictionary objectForKey:@"G"]]];
    }
    if ([attributeDictionary objectForKey:@"S"]) {
        [attributeArray addObject:[NSString stringWithFormat:@"setter=%@", [attributeDictionary objectForKey:@"S"]]];
    }
    if ([attributeDictionary objectForKey:@"D"]) {
        [res setObject:[NSNumber numberWithBool:YES] forKey:@"isDynamic"];
    } else {
        [res setObject:[NSNumber numberWithBool:NO] forKey:@"isDynamic"];
    }
    if ([attributeDictionary objectForKey:@"W"]) {
        [attributeArray addObject:@"weak"];
    }
    if ([attributeDictionary objectForKey:@"P"]) {
        
    }
    
    if ([attributeDictionary objectForKey:@"T"]) {
        
        NSDictionary *typeDic = @{@"c":@"char",
                                  @"i":@"int",
                                  @"s":@"short",
                                  @"l":@"long",
                                  @"q":@"long long",
                                  @"C":@"unsigned char",
                                  @"I":@"unsigned int",
                                  @"S":@"unsigned short",
                                  @"L":@"unsigned long",
                                  @"Q":@"unsigned long long",
                                  @"f":@"float",
                                  @"d":@"double",
                                  @"B":@"BOOL",
                                  @"v":@"void",
                                  @"*":@"char *",
                                  @"@":@"id",
                                  @"#":@"Class",
                                  @":":@"SEL",
                                  };
        NSString *key = [attributeDictionary objectForKey:@"T"];
        
        id type_str = [typeDic objectForKey:key];
        
        if (type_str == nil) {
            if ([[key substringToIndex:1] isEqualToString:@"@"] && [key rangeOfString:@"?"].location == NSNotFound) {
                type_str = [[key substringWithRange:NSMakeRange(2, key.length - 3)] stringByAppendingString:@"*"];
            } else if ([[key substringToIndex:1] isEqualToString:@"^"]) {
                id str = [typeDic objectForKey:[key substringFromIndex:1]];
                if (str) {
                    type_str = [NSString stringWithFormat:@"%@ *", str];
                }
            } else {
                type_str = @"unknow";
            }
        }
        [res setObject:type_str forKey:@"type"];
    }
    
    [res setObject:attributeArray forKey:@"attribute"];
    
    return res;
}

+ (NSString *)decodeType:(const char *)cString {
    NSLog(@"%s", @encode(long long));
    NSLog(@"%s", @encode(long));
    if (!strcmp(cString, @encode(char))) {
        return @"char";
    }
    if (!strcmp(cString, @encode(int))) {
        return @"int";
    }
    if (!strcmp(cString, @encode(short))) {
        return @"short";
    }
    if (!strcmp(cString, @encode(long long))) {
        return @"long long";
    }
    if (!strcmp(cString, @encode(long))) {
        return @"long";
    }
    if (!strcmp(cString, @encode(unsigned char))) {
        return @"unsigned char";
    }
    if (!strcmp(cString, @encode(unsigned int))) {
        return @"unsigned int";
    }
    if (!strcmp(cString, @encode(unsigned short))) {
        return @"unsigned short";
    }
    if (!strcmp(cString, @encode(unsigned long))) {
        return @"unsigned long";
    }
    if (!strcmp(cString, @encode(unsigned long long))) {
        return @"unsigned long long";
    }
    if (!strcmp(cString, @encode(float))) {
        return @"float";
    }
    if (!strcmp(cString, @encode(double))) {
        return @"double";
    }
    if (!strcmp(cString, @encode(BOOL))) {
        return @"BOOL";
    }
    if (!strcmp(cString, @encode(_Bool))) {
        return @"_Bool";
    }
    if (!strcmp(cString, @encode(void))) {
        return @"void";
    }
    if (!strcmp(cString, @encode(char *))) {
        return @"char *";
    }
    if (!strcmp(cString, @encode(id))) {
        return @"id";
    }
    if (!strcmp(cString, @encode(Class))) {
        return @"Class";
    }
    if (!strcmp(cString, @encode(SEL))) {
        return @"SEL";
    }
    if (!strcmp(cString, @encode(Boolean))) {
        return @"Boolean";
    }
    
    NSString *res = [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
    
    if ([[res substringToIndex:1] isEqualToString:@"@"] && [res rangeOfString:@"?"].location == NSNotFound) {
        res = [[res substringWithRange:NSMakeRange(2, res.length - 3)] stringByAppendingString:@"*"];
    } else {
        if ([[res substringToIndex:1] isEqualToString:@"^"]) {
            res = [NSString stringWithFormat:@"%@ *", [NSString decodeType:[[res substringFromIndex:1] cStringUsingEncoding:NSUTF8StringEncoding]]];
        }
    }
    
    return res;
}

- (NSArray *)ivarList {
    return [[self class] ivarList];
}

+ (NSArray *)ivarList {
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    
    NSMutableArray *res = [NSMutableArray array];
    for (int i = 0; i < outCount; i++) {
        NSString *type = [[self class] decodeType:ivar_getTypeEncoding(ivars[i])];
        NSString *name = [NSString stringWithCString:ivar_getName(ivars[i]) encoding:NSUTF8StringEncoding];
        
        NSString *ivarDesc = [NSString stringWithFormat:@"%@ %@", type, name];
        [res addObject:ivarDesc];
    }
    
    free(ivars);
    
    return res;
}

- (NSArray *)instanceMethodList {
    return [[self class] instanceMethodList];
}

+ (NSArray *)instanceMethodList {
    
    u_int count;
    
    NSMutableArray *methodList = [NSMutableArray array];
    Method *methods = class_copyMethodList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        [methodList addObject:strName];
    }
    
    free(methods);
    
    return methodList;
}

- (NSArray *)classMethodList {
    return [[self class] classMethodList];
}

+ (NSArray *)classMethodList {
    u_int count;
    
    NSMutableArray *methodList = [NSMutableArray array];
    Method *methods = class_copyMethodList(object_getClass(self), &count);
    
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL methodName = method_getName(method);
        [methodList addObject:NSStringFromSelector(methodName)];
    }
    
    free(methods);
    
    return methodList;
}

- (NSDictionary *)protocolInfo {
    return [[self class] protocolInfo];
}

+ (NSDictionary *)protocolInfo {
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    u_int count;
    Protocol * __unsafe_unretained * protocols = class_copyProtocolList([self class], &count);
    for (int i = 0; i < count; i++) {
        Protocol *protocol = protocols[i];
        
        NSString *protocolName = [NSString stringWithCString:protocol_getName(protocol) encoding:NSUTF8StringEncoding];
        
        NSMutableArray *superProtocolArray = ({
            NSMutableArray *array = [NSMutableArray array];
            
            u_int superProtocolCount;
            Protocol * __unsafe_unretained *superProtocols = protocol_copyProtocolList(protocol, &superProtocolCount);
            
            for (int ii = 0; ii < superProtocolCount; ii++) {
                Protocol *superProtocol = superProtocols[ii];
                NSString *superProtocolName = [NSString stringWithCString:protocol_getName(superProtocol) encoding:NSUTF8StringEncoding];
                
                [array addObject:superProtocolName];
            }
            
            free(superProtocols);
            
            array;
        });
        
        [dictionary setObject:superProtocolArray forKey:protocolName];
    }
    
    free(protocols);
    
    return dictionary;
}

+ (void)swizzlingInstanceMethod:(SEL)oldMethod newMethod:(SEL)newMethod {
    
    Class class = [self class];
    
    SEL originalSelector = oldMethod;
    SEL swizzledSelector = newMethod;
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)swizzlingClassMethod:(SEL)oldMethod newMethod:(SEL)newMethod {
    
    Class class = object_getClass(self);
    
    SEL originalSelector = oldMethod;
    SEL swizzledSelector = newMethod;
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [self init]) {
        // 获取类的属性和属性对应的类型
        NSMutableArray *keys = [NSMutableArray array];
        NSMutableArray *attributes = [NSMutableArray array];
        
        u_int outCount;
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            
            // 通过property_getName函数获得属性的名字
            NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            [keys addObject:propertyName];
            
            NSString *propertyAttribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            [attributes addObject:propertyAttribute];
        }
        
        free(properties);
        
        for (NSString *key in keys) {
            if ([dict valueForKey:key] == nil) {
                continue;
            }
            [self setValue:[dict valueForKey:key] forKey:key];
        }
    }
    return self;
}

@end
