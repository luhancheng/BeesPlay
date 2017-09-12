//
//  AppDelegate.h
//  BeesPlay
//
//  Created by 路与心 on 2017/9/11.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "GuidePageView.h" // 引导页
#import "WXApi.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,GuidePageDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) Reachability *reachability;
@property (assign, nonatomic) BOOL isNetworkConnected;
@property (nonatomic, strong) GuidePageView *guidePage;
@end

