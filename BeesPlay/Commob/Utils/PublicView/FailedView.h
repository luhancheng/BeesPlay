//
//  FailedView.h
//  goujiawang
//
//  Created by iPhone on 15/7/14.
//  Copyright (c) 2015年 iPhone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FailedViewDelegate <NSObject>

- (void) reloadDataClick;

@end

@interface FailedView : UIView

@property (nonatomic, assign) id<FailedViewDelegate>delegate;
@property (nonatomic, strong) UILabel *errorMsgLabel;
@property (nonatomic, strong) UIImageView *errorImageView;
@property (nonatomic, strong) UIButton *reloadButton;

/**
 *  错误视图初始化
 *
 *  @param errorTitle     错误标题
 *  @param errorImageName 错误标示图片
 *
 *  @return 错误视图
 */
- (id)initWithErrorTitle:(NSString *)errorTitle errorImageName:(NSString *)errorImageName;
- (id)initWithErrorTitle:(NSString *)errorTitle errorImageName:(NSString *)errorImageName frame:(CGRect)frame;
//隐藏
- (void) hiddenFailedView;
//显示
- (void) showInView:(UIView *)view;
@end
