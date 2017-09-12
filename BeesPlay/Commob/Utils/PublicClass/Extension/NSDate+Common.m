//
//  NSDate+Coommon.m
//  Pic61
//
//  Created by Iphone on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NSDate+Common.h"

@implementation NSDate (Common)

- (NSInteger)minutesAfterNumWithTimestamp:(NSString *)timestamp
{
    return [self timeAfterNumType:NSCalendarUnitMinute timestamp:timestamp];
}
- (NSInteger)timeAfterNumType:(NSCalendarUnit)unitFlags timestamp:(NSString *)timestamp
{
    if (timestamp.length >= 10) {
        NSDate * date = [NSDate dateWithTimeIntervalSince1970:[[timestamp substringToIndex:10] longLongValue]];
        
        NSCalendar * gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents * comps = [gregorian components:unitFlags fromDate:date toDate:self options:0];
        
        if (unitFlags == NSCalendarUnitYear)
            return [comps year];
        else if (unitFlags == NSCalendarUnitMonth)
            return [comps month];
        else if (unitFlags == NSCalendarUnitDay)
            return [comps day];
        else if (unitFlags == NSCalendarUnitHour)
            return [comps hour];
        else if (unitFlags == NSCalendarUnitMinute)
            return [comps minute];
        else if (NSCalendarUnitSecond)
            return [comps second];
        else
            return 0;
    } else
        return 0;
}

+ (NSString *)getDateValue:(NSString *)aStr andFormatter:(NSString *)formatterStr
{
    if ([aStr isKindOfClass:[NSDate class]])
        return nil;
    
    @try {
        NSString *timestamp;
        if ([aStr isKindOfClass:[NSDate class]])
            timestamp = [NSString stringWithFormat:@"%ld", (long)[(NSDate *)aStr timeIntervalSince1970]];
        else
            timestamp = aStr;
        
        if (timestamp.length >= 10) {
            NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
            [dateformatter setDateFormat:formatterStr];
            
            NSString *dateStr = [timestamp substringFromIndex:0];
            //获取数字的位数，一般情况下像1394765482125的数字，后三个是代表毫秒的，所以我们去掉后三个
            NSString * tempStr = [dateStr substringToIndex:10];
            NSDate * dd = [NSDate dateWithTimeIntervalSince1970:[tempStr longLongValue]];
            NSString *dateString = [dateformatter stringFromDate:dd];
            
            return dateString;
        } else{
            NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
            [dateformatter setDateFormat:formatterStr];
            
            NSString *dateStr = [timestamp substringFromIndex:0];
            //获取数字的位数，一般情况下像1394765482125的数字，后三个是代表毫秒的，所以我们去掉后三个
            NSString * tempStr = [dateStr substringToIndex:timestamp.length];
            NSDate * dd = [NSDate dateWithTimeIntervalSince1970:[tempStr longLongValue]];
            NSString *dateString = [dateformatter stringFromDate:dd];
            return dateString;
        }
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        
    }
}

@end
