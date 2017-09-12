//
//  HttpManager.m
//  GoodProductOfHome
//
//  Created by 路瀚程的MacBook Pro on 16/5/13.
//  Copyright © 2016年 bxkj. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager
+ (void)netWorkStatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //        NSLog(@"%ld", status);
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"---------------------------主页面-不知道什么网络");
               
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"---------------------------主页面-没有网络");
             
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"---------------------------主页面-手机网络");
             
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"---------------------------主页面-WIFI网络");
                break;
            default:
                break;
        }
    }];
}

/**
 *  GET 方式获取 JSON 数据
 *
 *  @param url     获取数据的 url 地址
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+ (void)getJSONDataWithUrl:(NSString *)url
                   success:(void (^)(id json))success
                      fail:(void (^)())fail {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
    NSDictionary *dic = @{@"format": @"json"};
    [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
        //        NSLog(@"%lld---%lld", downloadProgress.completedUnitCount , downloadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject) ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (fail) {
            NSLog(@"%@",error);
            fail ();
        }
        
    }];
}

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
                       fail:(void (^)())fail {
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer.timeoutInterval = 60.f;
    
    [session POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //        NSLog(@"请求进度~");
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
        
        if (success) {
            success(mDic) ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail () ;
        
    }];
}

@end
