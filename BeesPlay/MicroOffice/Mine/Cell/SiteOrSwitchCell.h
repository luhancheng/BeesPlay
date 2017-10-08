//
//  SiteOrSwitchCell.h
//  BeesPlay
//
//  Created by 路与心 on 2017/9/29.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiteOrSwitchModel.h"
@interface SiteOrSwitchCell : UITableViewCell
@property(nonatomic,strong) UILabel *workAddressLabel;
@property(nonatomic,strong) UILabel *undertakeLabel;
@property(nonatomic,strong) UILabel *workStatusLabel;

@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UIImageView *personImage;
@property (nonatomic, strong) UILabel *titeL;
@property (nonatomic, strong) UILabel *mesageL;
@property (nonatomic, strong) UILabel *dateL;
@property (nonatomic, strong) UILabel *numberL;

- (id)initWithItem:(SiteOrSwitchModel *)item;

@end
