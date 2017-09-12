//
//  AppDelegate.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/11.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "BaseNavigationController.h"
//#import "LoginViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#define APP_ID          @"wx30ff9b844925f4ec"               //APPID
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [NSThread sleepForTimeInterval:1];
    
    [self.window makeKeyAndVisible];
    //MainTabBarViewController *rootVC = [MainTabBarViewController new];
    //rootVC.delegate = self;
    //self.window.rootViewController = rootVC;
    self.window.rootViewController = ({MainTabBarViewController *rootVC = [MainTabBarViewController new]; rootVC;});//改着着玩的😄
    if([USERDEFAULTS boolForKey:@"firstStart"] == NO){//首次登陆显示引导页....目前隐藏
        
         //_guidePage = [[GuidePageView alloc] initWithFrame:self.window.frame];
         //_guidePage.delegate = self;
        //  [self.window addSubview:_guidePage];
        
    }
    
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    self.reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];//可以以多种形式初始化
    
    self.reachability.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    };
    
    self.reachability.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    };
    [self.reachability startNotifier];  //开始监听,会启动一个run loop
    
    //向微信注册
    [WXApi registerApp:APP_ID withDescription:@"XiongBaBa"];
    return YES;
}

// 网络状态改变
- (void) reachabilityChanged:(NSNotification *)curReach {
    //对连接改变做出响应的处理动作。
    self.reachability = [curReach object];
    NetworkStatus status = [self.reachability currentReachabilityStatus];
    
    if (status == NotReachable) {  //没有连接到网络就弹出提实况
        
        [self.window makeToast:@"网络不可用，请检查手机网络连接！"];
        
        self.isNetworkConnected = NO;
    } else {
        self.isNetworkConnected = YES;
    }
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    // 微信授权登录
    if ([url.host isEqual:@"oauth"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    // QQ 授权登录
    if ([url.host isEqual:@"qzapp"]) {
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES ;
}

-(void)onResp:(BaseResp *)resp {
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]]) {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *aresp = (SendAuthResp *)resp;
        strTitle = [NSString stringWithFormat:@"微信授权登录结果"];
        if (aresp.errCode == 0) {
            strMsg = [NSString stringWithFormat:@"微信授权登录成功~"];
            NSString *code = aresp.code;
            NSDictionary *dic = @{@"code":code};
            // 发通知提示登录成功~
            NSNotification *notification = [NSNotification notificationWithName:@"WechatAuthResult" object:nil userInfo:dic];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }else {
            strMsg = [NSString stringWithFormat:@"微信授权登录失败~"];
        }
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)onDoneButtonPressed {
    
    [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _guidePage.alpha = 0;
    } completion:^(BOOL finished) {
        [_guidePage removeFromSuperview];
        
        [USERDEFAULTS setBool:YES forKey:@"firstStart"];
    }];
    
    DLog(@"1111");
}

@end
