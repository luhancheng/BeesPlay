//
//  NSDate+Coommon.h
//  Pic61
//
//  Created by Iphone on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Common)

// 距离当前时间多少分钟
- (NSInteger)minutesAfterNumWithTimestamp:(NSString *)timestamp;

+ (NSString *)getDateValue:(NSString *)aStr andFormatter:(NSString *)formatterStr;

@end
