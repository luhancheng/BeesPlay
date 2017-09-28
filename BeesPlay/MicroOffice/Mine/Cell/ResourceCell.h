//
//  ResourceCell.h
//  BeesPlay
//
//  Created by 路与心 on 2017/9/26.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResourceModel.h"
@interface ResourceCell : UITableViewCell
@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *createDateTime;    // 创建日期
@property (nonatomic, strong) UIImageView *eyeImage;
@property (nonatomic, strong) UILabel *number;//数量

- (id)initWithItem:(ResourceModel *)item;
@end
