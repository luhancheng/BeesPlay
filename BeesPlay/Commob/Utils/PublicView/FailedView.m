//
//  FailedView.m
//  goujiawang
//
//  Created by iPhone on 15/7/14.
//  Copyright (c) 2015年 iPhone. All rights reserved.
//

#import "FailedView.h"

@implementation FailedView

- (id)initWithErrorTitle:(NSString *)errorTitle errorImageName:(NSString *)errorImageName
{
    self = [super initWithFrame:CGRectMake(0, TOP_BLANNER_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - TOP_BLANNER_HEIGHT)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.reloadButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.reloadButton.backgroundColor = [UIColor clearColor];
        [self.reloadButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.reloadButton];
        // Initialization code
        
        
        if (errorImageName) {
            self.errorImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) / 2, (SCREEN_HEIGHT - TOP_BLANNER_HEIGHT) / 2 - 50, 100, 100)];
            DLog(@"%f",SCREEN_HEIGHT);
            DLog(@"%f",(SCREEN_HEIGHT - TOP_BLANNER_HEIGHT) / 2 - 50);
            self.errorImageView.contentMode = UIViewContentModeTop;
            self.errorImageView.clipsToBounds = NO;
            if (errorImageName.length == 0) {
                self.errorImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 144) / 2, (SCREEN_HEIGHT - TOP_BLANNER_HEIGHT) / 2 - 70, 144, 128)];
                self.errorImageView.contentMode = UIViewContentModeScaleAspectFill;
                errorImageName = @"pic1105tunchRefresh.png";
            }
            [self.errorImageView setImage:[UIImage imageNamed:errorImageName]];
            [self addSubview:self.errorImageView];
        }
        if (errorTitle) { //错误消息
            CGFloat labelY = self.errorImageView?self.errorImageView.frame.origin.y + self.errorImageView.frame.size.height + 10 : (SCREEN_HEIGHT - TOP_BLANNER_HEIGHT) / 2 + 60;
            self.errorMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, labelY, SCREEN_WIDTH, 20)];
            [self.errorMsgLabel setBackgroundColor:[UIColor clearColor]];
            [self.errorMsgLabel setText:errorTitle];
            [self.errorMsgLabel setFont:[UIFont systemFontOfSize:14.0]];
            [self.errorMsgLabel setTextAlignment:NSTextAlignmentCenter];
            [self.errorMsgLabel setTextColor:[UIColor lightGrayColor]];
            [self addSubview: self.errorMsgLabel];
        }
        
        
    }
    return self;
}

- (id)initWithErrorTitle:(NSString *)errorTitle errorImageName:(NSString *)errorImageName frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // Initialization code
        if (errorTitle) { //错误消息
            self.errorMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height / 2 + 60, frame.size.width, 20)];
            [self.errorMsgLabel setBackgroundColor:[UIColor clearColor]];
            [self.errorMsgLabel setText:errorTitle];
            [self.errorMsgLabel setFont:[UIFont systemFontOfSize:14.0]];
            [self.errorMsgLabel setTextAlignment:NSTextAlignmentCenter];
            [self.errorMsgLabel setTextColor:[UIColor lightGrayColor]];
            [self addSubview: self.errorMsgLabel];
        }
        
        if (errorImageName) {
            self.errorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, frame.size.height / 2 - 50, 100, 100)];
            DLog(@"%f",SCREEN_HEIGHT);
            DLog(@"%f",(SCREEN_HEIGHT - TOP_BLANNER_HEIGHT) / 2 - 50);
            self.errorImageView.contentMode = UIViewContentModeTop;
            self.errorImageView.clipsToBounds = NO;
            [self.errorImageView setImage:[UIImage imageNamed:errorImageName]];
            [self addSubview:self.errorImageView];
        }
    }
    return self;
}

- (void) onClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(reloadDataClick)]) {
        [self.delegate reloadDataClick];
    }
}

- (void) showInView:(UIView *)view {
    self.alpha = 0.0;
    [view addSubview:self];
    if (self.reloadButton) {
        self.reloadButton.enabled = YES;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.alpha = 1.0;
    }];
}

- (void) hiddenFailedView {
    self.reloadButton.enabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.alpha = 0.0;
        DLog(@"2")
    }];
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
