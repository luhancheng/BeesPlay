//
//  AlbumModel.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/26.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "AlbumModel.h"

@implementation AlbumModel
+(AlbumModel *)modelWithDictionary: (NSDictionary *)dic {
    AlbumModel *model = [[AlbumModel alloc ]init];
    [model setValuesForKeysWithDictionary: dic ];
    return  model ;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}

@end
