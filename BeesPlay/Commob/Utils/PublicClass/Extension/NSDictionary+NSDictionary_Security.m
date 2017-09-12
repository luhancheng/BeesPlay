//
//  NSDictionary+NSDictionary_Security.m
//  Pic61
//
//  Created by iPhone on 14-7-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "NSDictionary+NSDictionary_Security.h"

@implementation NSDictionary (NSDictionary_Security)
- (NSArray *) securityArrayWithKey:(id)key {
    NSArray * array = [self objectForKey:key];
    if (array && [array isKindOfClass:[NSArray class]]) {
        return array;
    }
    return nil;
}


- (NSDictionary *) securityDictionaryWithKey:(id)key {
    NSDictionary * dictionary = [self objectForKey:key];
    if (dictionary && [dictionary isKindOfClass:[NSDictionary class]]) {
        return dictionary;
    }
    return nil;
}
- (BOOL) securityBOOLWithKey:(id)key {
    NSNumber *boolValue = [self objectForKey:key];
    if ([boolValue isKindOfClass:[NSNumber class]]) {
        return [boolValue boolValue];
    } else if ([boolValue isKindOfClass:[NSString class]]) {
        NSString *boolvaluestr = (NSString *)boolValue;
        if ([boolvaluestr isEqualToString:@"true"]) {
            return true;
        }
    }
    return false;
}

- (NSString *) securityStringWithKey:(id)key {
    NSString *string = [self objectForKey:key];
    if (string && [string isKindOfClass:[NSString class]]) {
        return string;
    } else if(!string) {
        return @"";
    } else if([string isKindOfClass:[NSNull class]]) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%@",string];
    }
}


- (int) securityIntWithKey:(id)key {
    NSNumber *number = [self objectForKey:key];
    int result = 0;
    
    if (number) {
        result = [number intValue];
    }
    NSString *string = [self objectForKey:key];
    if (string) {
        result = [string intValue];
    }
    return result;
}
@end
