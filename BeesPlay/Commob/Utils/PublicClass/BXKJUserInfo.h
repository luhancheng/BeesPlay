//
//  BXKJUserInfo.h
//  GoodProductOfHome
//
//  Created by 路瀚程的MacBook Pro on 16/5/13.
//  Copyright © 2016年 bxkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BXKJUserInfo : NSObject

@property (nonatomic,strong) NSString *userName;     // 用户名
@property (nonatomic,strong) NSString *nickName;     // 昵称
@property (nonatomic,strong) NSString *userId;       // 用户id
@property (nonatomic,strong) NSString *token;       //
@property (nonatomic,strong) NSString *phone;        // 手机号
@property (nonatomic,strong) NSString *avatarImg;    //头像图片路径
@property (nonatomic,strong) NSString *couldUpdateNick;//是否能修改昵称;1:能;0:不

- (id)initWithFields:(NSDictionary *)fields;

+ (BXKJUserInfo *)getUserInfoFromCache;

- (void)saveUserInfo;
+ (void)removeUserInfo;
@end
