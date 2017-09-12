//
//  Defines.h
//  GoodProductOfHome
//
//  Created by 路瀚程的MacBook Pro on 16/5/12.
//  Copyright © 2016年 bxkj. All rights reserved.
//

#ifndef Defines_h
#define Defines_h


//设备屏幕大小
#define __MainScreenFrame   [[UIScreen mainScreen] bounds]
//设备屏幕宽
#define __MainScreen_Width  __MainScreenFrame.size.width
//设备屏幕高 20,表示状态栏高度.如3.5inch 的高,得到的__MainScreenFrame.size.height是480,而去掉电量那条状态栏,我们真正用到的是460;

#define SCREEN_WIDTH __MainScreenFrame.size.width //屏幕宽度
#define TOP_BLANNER_HEIGHT  (IOS7?64:44) //顶部Logo背景条的高度

#define IOS8 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0)
#define IOS7 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0)
#define IOS6 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 6.0)

#define SCREEN_HEIGHT (IOS7?__MainScreenFrame.size.height:__MainScreenFrame.size.height-20) //屏幕高度
#define FULL_SCREEN_HEIGHT __MainScreenFrame.size.height

#define USERDEFAULTS [NSUserDefaults standardUserDefaults] //NSUserDefaults
#define SINGLETON    [Singleton shareSingleton]   // 单例
#define kHexColor(str) [UIColor colorWithHexString:str] //直接给16进制的颜色

#define MAINCOLOR [UIColor colorWithRed:255/255.0 green:86/255.0 blue:0/255.0 alpha:1]

//rgb颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define kScreenWidth [UIScreen mainScreen].bounds.size.width   //屏幕的宽度
#define kScreenHeight (IOS7?__MainScreenFrame.size.height:__MainScreenFrame.size.height-20) //屏幕高度


#define WIDTH(num)   kScreenWidth * (num) / 320.0


//服务器地址
#define BX_URL @"http://appserver.ibaixiong.com"   //正式环境
#define BX_DRP @"http://drp-appserver.ibaixiong.com" 

//#define BASE_HOST @"http://tdiy.goujiawang.com"  //测试环境1




#endif /* Defines_h */










