//
//  HomeCollectionViewCell.m
//  BeesPlay
//
//  Created by 路与心 on 2017/10/9.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //添加子控件
        self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.font = [UIFont boldSystemFontOfSize:23];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor lightGrayColor];

        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}
@end
