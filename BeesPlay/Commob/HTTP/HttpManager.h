//
//  HttpManager.h
//  GoodProductOfHome
//
//  Created by 路瀚程的MacBook Pro on 16/5/13.
//  Copyright © 2016年 bxkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface HttpManager : NSObject
/**检测网路状态**/
+ (void)netWorkStatus;
/**
 *  GET 方式获取 JSON 数据
 *
 *  @param url     获取数据的 url 地址
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+ (void)getJSONDataWithUrl:(NSString *)url
                   success:(void (^)(id json))success
                      fail:(void (^)())fail ;

/**
 *  POST 方式获取 JSON 数据
 *
 *  @param url     获取数据地址
 *  @param params  数据参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+ (void)postJSONDataWithUrl:(NSString *)url
                     params:(NSDictionary *) params
                     succss:(void (^)(id json))success
                       fail:(void (^)())fail ;

@end
