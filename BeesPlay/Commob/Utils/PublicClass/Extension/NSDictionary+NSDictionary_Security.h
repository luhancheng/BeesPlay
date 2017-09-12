//
//  NSDictionary+NSDictionary_Security.h
//  Pic61
//
//  Created by iPhone on 14-7-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NSDictionary_Security)
- (NSString *) securityStringWithKey:(id)key;
- (NSDictionary *) securityDictionaryWithKey:(id)key;
- (NSArray *) securityArrayWithKey:(id)key;
- (BOOL) securityBOOLWithKey:(id)key;
- (int) securityIntWithKey:(id)key;
@end
