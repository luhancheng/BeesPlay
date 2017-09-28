//
//  ResourceModel.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/26.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "ResourceModel.h"

@implementation ResourceModel
+(ResourceModel *)modelWithDictionary: (NSDictionary *)dic {
    ResourceModel *model = [[ResourceModel alloc ]init];
    [model setValuesForKeysWithDictionary: dic ];
    return  model ;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}

+ (ResourceModel*)initWith:(NSDictionary *)dic {
    
    ResourceModel *model = [[ResourceModel alloc]init];
    
    if (dic) {
        
     //model.number   = [dic securityIntWithKey:@"number"];
        model.title       = [dic securityStringWithKey:@"title"];
        model.createDateTime    = [dic securityStringWithKey:@"createDateTime"];
        model.name            = [dic securityStringWithKey:@"name"];
    }
    
    return model;
   
}
@end
