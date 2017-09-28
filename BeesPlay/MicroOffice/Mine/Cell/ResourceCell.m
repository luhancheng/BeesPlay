//
//  ResourceCell.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/26.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "ResourceCell.h"
@implementation ResourceCell

- (id)initWithItem:(ResourceModel *)item {
    
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, WIDTH(80))];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *bgPic = [[UIImageView alloc] initWithFrame:self.frame];
        
        bgPic.image = [UIImage imageNamed:@"任务框BG@2x"];
        
        [self addSubview:bgPic];
        
        self.headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bgPic.height, bgPic.height)];
        self.headerImage.image = [UIImage imageNamed:@"logo"];
        [bgPic addSubview:self.headerImage];
        self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImage.right+10, self.headerImage.top, self.contentView.width - self.headerImage.right-10, 20) text:@"网络互联网上的设备与多层交换" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:20]];
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(self.titleL.left, self.centerY,self.titleL.width, 15) text:@"呆呆" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:15]];
        self.createDateTime = [[UILabel alloc] initWithFrame:CGRectMake(self.titleL.left, self.headerImage.bottom-15, WIDTH(180), 15) text:@"07-25"  textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:15]];
        [bgPic addSubview:self.createDateTime];
        
        
        self.number = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.width - 60-WIDTH(10), self.createDateTime.top, 60, WIDTH(16)) text:@"234" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:WIDTH(16)]];
        self.number.textAlignment = NSTextAlignmentRight;
        //self.number.text = [NSString stringWithFormat:@"%@",_model.userName];
        [bgPic addSubview:self.number];
        if (self.number.text.length != 0) {
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.number.text];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            [paragraphStyle setLineSpacing:5];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.number.text.length)];
            self.number.attributedText = attributedString;
            //调节高度
            CGSize size = CGSizeMake(MAXFLOAT, 20);
            CGSize labelSize = [self.number sizeThatFits:size];
            self.number.frame = CGRectMake(self.contentView.width - WIDTH(10) - labelSize.width, self.createDateTime.top ,labelSize.width, WIDTH(16));
        }
        
        self.eyeImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.number.width - self.number.left - self.number.height , self.number.top, self.number.height, self.number.height)];
        self.eyeImage.image = [UIImage imageNamed:@"eye"];
        [bgPic addSubview:self.eyeImage];
 
        
    }
    
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
