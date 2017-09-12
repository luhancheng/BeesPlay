//
//  BXKJUserInfo.m
//  GoodProductOfHome
//
//  Created by 路瀚程的MacBook Pro on 16/5/13.
//  Copyright © 2016年 bxkj. All rights reserved.
//

#import "BXKJUserInfo.h"

@implementation BXKJUserInfo

- (id)initWithFields:(NSDictionary *)fields
{
    self = [self init];
    self.userId       = [fields securityStringWithKey:@"id"];
    self.userName     = [fields securityStringWithKey:@"userName"];
    self.nickName     = [fields securityStringWithKey:@"nickName"];
    self.token        = [fields securityStringWithKey:@"token"];
    self.phone        = [fields securityStringWithKey:@"phone"];
    self.avatarImg    = [fields securityStringWithKey:@"avatarImg"];
    self.couldUpdateNick = [fields securityStringWithKey:@"couldUpdateNick"];
    return self;
}

- (void)saveUserInfo
{
    
    [USERDEFAULTS setValue:self.userId       forKey:@"userId"];
    [USERDEFAULTS setValue:self.userName     forKey:@"userName"];
    [USERDEFAULTS setValue:self.nickName     forKey:@"nickName"];
    [USERDEFAULTS setValue:self.token        forKey:@"token"];
    [USERDEFAULTS setValue:self.phone        forKey:@"phone"];
    [USERDEFAULTS setValue:self.avatarImg    forKey:@"avatarImg"];
    [USERDEFAULTS setObject:self.couldUpdateNick forKey:@"couldUpdateNick"];
}

+ (BXKJUserInfo *)getUserInfoFromCache
{
    BXKJUserInfo *userInfo = [[BXKJUserInfo alloc] init];
    
    userInfo.userId       = [USERDEFAULTS valueForKey:@"userId"];
    userInfo.userName     = [USERDEFAULTS valueForKey:@"userName"];
    userInfo.nickName     = [USERDEFAULTS valueForKey:@"nickName"];
    userInfo.token        = [USERDEFAULTS valueForKey:@"token"];
    userInfo.phone        = [USERDEFAULTS valueForKey:@"phone"];
    userInfo.avatarImg    = [USERDEFAULTS valueForKey:@"avatarImg"];
    userInfo.couldUpdateNick = [USERDEFAULTS valueForKey:@"couldUpdateNick"];
    
    return userInfo;
}

+ (void)removeUserInfo {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:@"userId"];
    [user removeObjectForKey:@"userName"];
    [user removeObjectForKey:@"nickName"];
    [user removeObjectForKey:@"token"];
    [user removeObjectForKey:@"phone"];
    [user removeObjectForKey:@"avatarImg"];
    [user removeObjectForKey:@"couldUpdateNick"];
    
}
@end












