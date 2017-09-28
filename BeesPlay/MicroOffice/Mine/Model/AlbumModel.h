//
//  AlbumModel.h
//  BeesPlay
//
//  Created by 路与心 on 2017/9/26.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AlbumModel : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *createDateTime;//日期
@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) NSInteger *number;

+ (AlbumModel *)modelWithDictionary: (NSDictionary *)dic ;
@end
