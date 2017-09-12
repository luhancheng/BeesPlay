//
//  Singleton.h
//  GoodProductOfHome
//
//  Created by 路瀚程的MacBook Pro on 16/5/12.
//  Copyright © 2016年 bxkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject

+ (Singleton *)shareSingleton;

@property(nonatomic,assign)BOOL isLogin;//判断是否登录

@end
