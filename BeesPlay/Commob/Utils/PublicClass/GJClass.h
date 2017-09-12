//
//  GJClass.h
//  goujiawang
//
//  Created by 钱锐博 on 15/7/15.
//  Copyright (c) 2015年 iPhone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJClass : NSObject

@end

#pragma mark === UILabel,UITextField,UIButton ===
@interface UILabel (GradientBackground)
- (UIImage *) radialGradientImage:(CGSize)size start:(float)start end:(float)end centre:(CGPoint)centre radius:(float)radius;
- (id)initWithFrame:(CGRect)frame text:(NSString*)text;
- (id)initWithFrame:(CGRect)frame text:(NSString*)text textColor:(UIColor*)color;
- (id)initWithFrame:(CGRect)frame text:(NSString*)text textColor:(UIColor*)color font:(UIFont*)font;
- (CGSize)labelTextSize;
@end

@interface UITextField (CustomMethod)
- (id)initWithFrame:(CGRect)frame text:(NSString*)text placeholder:(NSString*)placeholder delegate:(id<UITextFieldDelegate>)delegate;
@end

@interface UIButton (CustomMethod)
- (id)initWithFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor*)color backgroundImageNames:(NSArray*)names target:(id)target action:(SEL)action;
- (id)initWithFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor*)color font:(UIFont*)font backgroundImageNames:(NSArray*)names target:(id)target action:(SEL)action;
- (id)initWithFrame:(CGRect)frame imageNames:(NSArray*)names target:(id)target action:(SEL)action;



- (id)initWithFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor *)color target:(id)target action:(SEL)action;


@end

#pragma mark =====更加UIColor得到UIImage=====
@interface UIImage (ImageColor)
+ ( UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end

#pragma mark =====判断一个字符串是否为空=====
@interface NSString (StringNull)
+ (BOOL)isNotNull:(NSString *)string;
@end


CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (ViewFrameGeometry)
@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;
@end
