//
//  Singleton.m
//  GoodProductOfHome
//
//  Created by 路瀚程的MacBook Pro on 16/5/12.
//  Copyright © 2016年 bxkj. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton
static Singleton *singleton=nil;
+ (Singleton *)shareSingleton
{
    @synchronized(self){
        
        if (singleton==nil) {
            singleton=[[Singleton alloc] init];
        }
    }
    return singleton;
}
@end
