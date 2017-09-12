//
//  GuidePageView.m
//  GoodProductOfHome
//
//  Created by 路瀚程的MacBook Pro on 16/5/22.
//  Copyright © 2016年 bxkj. All rights reserved.
//

#import "GuidePageView.h"

@implementation GuidePageView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        NSString *screenName = nil;
        if (kScreenHeight == 480) {
            screenName = @"(640-960)";
        }else if (kScreenHeight == 568) {
            screenName = @"(640-1136)";
        }else if (kScreenHeight == 667) {
            screenName = @"(750-1334)";
        }else if (kScreenHeight == 736) {
            screenName = @"(1242-2208)";
        }
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(kScreenWidth * 3, kScreenHeight);
        [self addSubview:_scrollView];
        
        for (int i = 0; i < 3; i ++ ) {
            
            UIImageView *imgView = [[UIImageView alloc] init];
            imgView.frame = CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight);
            imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"引导页%d%@", i+1, screenName]]; // 引导页1(640-960)
            DLog(@"image name === %@",[NSString stringWithFormat:@"引导页%d%@", i+1, screenName]);
            [self.scrollView addSubview:imgView];
            
            if (i == 2) {
                imgView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
                [imgView addGestureRecognizer:tap];
            }
        }
        
        _pagControl = [[UIPageControl alloc] initWithFrame:CGRectMake(100, kScreenHeight - 40, kScreenWidth - 200, WIDTH(8))];
        //        _pagControl.backgroundColor = [UIColor cyanColor];
        _pagControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"000000" alpha:0.8];
        _pagControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"000000" alpha:0.4];;
        _pagControl.currentPage = 0;
        _pagControl.numberOfPages = 3;
        [_pagControl addTarget:self action:@selector(clickPageAction:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pagControl];
    }
    
    return self;
    
}

- (void)clickPageAction:(UIPageControl *)pageControl {
    
    NSInteger page = pageControl.currentPage;
    
    NSInteger offsetX = page * kScreenWidth; // 宽度不要写死
    
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)tapAction {
    
    [self.delegate onDoneButtonPressed];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    DLog(@"%f",scrollView.contentOffset.x);
    
    NSInteger page = scrollView.contentOffset.x / kScreenWidth; // 宽度不要写死
    
    _pagControl.currentPage = page;
}


@end
