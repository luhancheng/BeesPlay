//
//  GuidePageView.h
//  GoodProductOfHome
//
//  Created by 路瀚程的MacBook Pro on 16/5/22.
//  Copyright © 2016年 bxkj. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GuidePageDelegate <NSObject>

- (void)onDoneButtonPressed;

@end
@interface GuidePageView : UIView<UIScrollViewDelegate>
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIPageControl *pagControl;
@property(nonatomic, strong)UIButton *button;

@property(nonatomic, strong)id <GuidePageDelegate>delegate;
@end
