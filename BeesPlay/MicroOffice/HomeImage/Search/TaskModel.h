//
//  TaskModel.h
//  BeesPlay
//
//  Created by 路与心 on 2017/9/25.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskModel : NSObject
@property(nonatomic,strong)NSString *chatContent;   // 发言的内容
@property(nonatomic,strong)NSString *content;       // 任务名称
@property(nonatomic,strong)NSString *createTime;    // 任务创建时间
@property(nonatomic,strong)NSString *ID;            // 任务id
@property(nonatomic,strong)NSString *isDeal;        // 0:待办 1:已办

@property(nonatomic,strong)NSString *isUrgency;     // 是否紧急 false:不紧急true:紧急
@property(nonatomic,strong)NSString *latestTime;    // 任务的最新发言时间
@property(nonatomic,strong)NSString *parentContent; // 任务来源名称
@property(nonatomic,strong)NSString *parentId;      // 任务来源
@property(nonatomic,strong)NSString *picPath;       // 任务的图片路径

@property(nonatomic,strong)NSString *planEndDate;   // 计划结束时间
@property(nonatomic,strong)NSString *planStartDate; // 计划开始时间
@property(nonatomic,strong)NSString *taskStatus;    // 任务状态:0未开始 1进行中 2已延期 3已取消 4已完成
@property(nonatomic,strong)NSString *userName;      // 任务发言人的名字

+ (TaskModel *)initWith:(NSDictionary *)dic;
@end
