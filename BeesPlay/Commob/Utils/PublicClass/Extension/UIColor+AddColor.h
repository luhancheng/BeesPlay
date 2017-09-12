//
//  UIColor+AddColor.h
//  goujiawang
//
//  Created by iPhone on 15/7/10.
//  Copyright (c) 2015年 iPhone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AddColor)
+ (UIColor *) colorWithHexString: (NSString *)color;
+ (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat)alpha;
+ (UIColor *) randomColor;
@end
