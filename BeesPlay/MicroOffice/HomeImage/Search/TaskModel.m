//
//  TaskModel.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/25.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "TaskModel.h"

@implementation TaskModel
+ (TaskModel *)initWith:(NSDictionary *)dic {
    
    TaskModel *model = [[TaskModel alloc] init];
    
    if (dic) {
        
        model.chatContent   = [dic securityStringWithKey:@"chatContent"];
        model.content       = [dic securityStringWithKey:@"content"];
        model.createTime    = [dic securityStringWithKey:@"createTime"];
        model.ID            = [dic securityStringWithKey:@"id"];
        model.isDeal        = [dic securityStringWithKey:@"isDeal"];
        
        model.isUrgency     = [dic securityStringWithKey:@"isUrgency"];
        model.latestTime    = [dic securityStringWithKey:@"latestTime"];
        model.parentContent = [dic securityStringWithKey:@"parentContent"];
        model.parentId      = [dic securityStringWithKey:@"parentId"];
        model.picPath       = [dic securityStringWithKey:@"picPath"];
        
        model.planEndDate   = [dic securityStringWithKey:@"planEndDate"];
        model.planStartDate = [dic securityStringWithKey:@"planStartDate"];
        model.taskStatus    = [dic securityStringWithKey:@"taskStatus"];
        model.userName      = [dic securityStringWithKey:@"userName"];
        
    }
    return model;
}

@end
