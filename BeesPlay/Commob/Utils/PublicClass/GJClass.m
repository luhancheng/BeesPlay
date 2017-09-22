//
//  GJClass.m
//  goujiawang
//
//  Created by 钱锐博 on 15/7/15.
//  Copyright (c) 2015年 iPhone. All rights reserved.
//

#import "GJClass.h"

@implementation GJClass

@end

@implementation UILabel (GradientBackground)
- (UIImage *)radialGradientImage:(CGSize)size start:(float)start end:(float)end centre:(CGPoint)centre radius:(float)radius
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    
    size_t count = 2;
    CGFloat locations[2] = {0.0, 1.0};
    CGFloat components[8] = {start, start, start, 1.0, end, end, end, 1.0};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef grad = CGGradientCreateWithColorComponents (colorSpace, components, locations, count);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawRadialGradient (UIGraphicsGetCurrentContext(), grad, centre, 0, centre, radius, kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(grad);
    UIGraphicsEndImageContext();
    return image;
}

- (id)initWithFrame:(CGRect)frame text:(NSString*)text{
    UILabel *label = [self initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    label.text = text;
    return label;
}

- (id)initWithFrame:(CGRect)frame text:(NSString*)text textColor:(UIColor*)color{
    UILabel *label = [self initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = color;
    label.text = text;
    return label;
}

- (id)initWithFrame:(CGRect)frame text:(NSString*)text textColor:(UIColor*)color font:(UIFont*)font{
    UILabel *label = [self initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = color;
    label.text = text;
    return label;
}

- (CGSize)labelTextSize{
    
    if (self.text.length > 0) {
        //        return [self.text sizeWithFont:self.font];
        return [self.text sizeWithAttributes:@{self.font:NSFontAttributeName}];
    }else{
        return CGSizeZero;
    }
    // todo
}

@end

@implementation UITextField (CustomMethod)

- (id)initWithFrame:(CGRect)frame text:(NSString*)text placeholder:(NSString*)placeholder delegate:(id<UITextFieldDelegate>)delegate{
    UITextField *textField = [self initWithFrame:frame];
    textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.returnKeyType = UIReturnKeyDone;
    textField.borderStyle = UITextBorderStyleBezel;
    textField.layer.cornerRadius = 4;
    textField.placeholder = placeholder;
    textField.delegate = delegate;
    textField.text = text;
//    textField.secureTextEntry = YES;
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont systemFontOfSize:16];
    return textField;
}

@end

@implementation UIButton (CustomMethod)

- (id)initWithFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor*)color backgroundImageNames:(NSArray*)names target:(id)target action:(SEL)action{
    UIButton *button = [self initWithFrame:frame];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:[names objectAtIndex:0]]stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:[names objectAtIndex:1]]stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title  textColor:(UIColor*)color font:(UIFont*)font backgroundImageNames:(NSArray*)names target:(id)target action:(SEL)action{
    UIButton *button = [self initWithFrame:frame];
    button.titleLabel.font = font;
    button.layer.cornerRadius = button.height/2;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:[names objectAtIndex:0]]stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:[names objectAtIndex:1]]stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (id)initWithFrame:(CGRect)frame imageNames:(NSArray*)names target:(id)target action:(SEL)action{
    UIButton *button = [self initWithFrame:frame];
    [button setImage:[UIImage imageNamed:[names objectAtIndex:0]] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:[names objectAtIndex:1]] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor *)color target:(id)target action:(SEL)action {
    
    UIButton *button = [self initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = button.height/2;
    return button;
    
}

@end

#pragma mark =====更加UIColor得到UIImage=====
@implementation UIImage (ImageColor)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake (0, 0, size.width, size.height);
    UIGraphicsBeginImageContext (rect. size );
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor (context,color.CGColor);
    CGContextFillRect (context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end

#pragma mark =====判断一个字符串是否为空=====
@implementation NSString (StringNull)
+ (BOOL)isNotNull:(NSString *)string
{
    if (string == nil || string == NULL || [string isEqual:[NSNull null]] || [string isEqualToString:@""] || [string isEqualToString:@"<null>"]) {
        return NO;
    }else{
        return YES;
    }
}
@end

#pragma mark ======= 获取View 的 frame ==

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

@implementation UIView (ViewGeometry)

// Retrieve and set the origin
- (CGPoint) origin
{
    return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint
{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}


// Retrieve and set the size
- (CGSize) size
{
    return self.frame.size;
}

- (void) setSize: (CGSize) aSize
{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint) bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) topRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}


// Retrieve and set height, width, top, bottom, left, right
- (CGFloat) height
{
    return self.frame.size.height;
}

- (void) setHeight: (CGFloat) newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat) width
{
    return self.frame.size.width;
}

- (void) setWidth: (CGFloat) newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat) top
{
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat) left
{
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

// Move via offset
- (void) moveBy: (CGPoint) delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

// Scaling
- (void) scaleBy: (CGFloat) scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}
@end
