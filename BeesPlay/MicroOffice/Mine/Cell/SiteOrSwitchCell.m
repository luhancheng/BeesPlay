//
//  SiteOrSwitchCell.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/29.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "SiteOrSwitchCell.h"

@implementation SiteOrSwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithItem:(SiteOrSwitchModel *)item {
   
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, WIDTH(80))];
    
    if (self) {
        
        //self.backgroundColor = [UIColor clearColor];
        
//        UIImageView *bgPic = [[UIImageView alloc] initWithFrame:self.frame];
//        
//        bgPic.image = [UIImage imageNamed:@"任务框BG@2x"];
//        
//        [self addSubview:bgPic];
        
        
        _headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH(10), WIDTH(10), self.contentView.height - WIDTH(20), self.contentView.height - WIDTH(20))];
        _headerImage.image = [UIImage imageNamed:@"logo"];
        [self.contentView addSubview:_headerImage];
        
        _titeL = [[UILabel alloc] initWithFrame:CGRectMake(_headerImage.right, _headerImage.top, self.contentView.width - _headerImage.right, WIDTH(15)) text:@"系统总站" textColor:kHexColor(@"333333") font:[UIFont boldSystemFontOfSize:15]];
        [self.contentView addSubview:_titeL];
        
        _mesageL = [[UILabel alloc] initWithFrame:CGRectMake(_headerImage.right, _titeL.top, self.contentView.width - _headerImage.right, _headerImage.height - WIDTH(30)) text:@"资源库是面向全国教师的新课程网络研修平台，也是中国教育课程改革推进的..." textColor:[UIColor lightGrayColor] font:[UIFont boldSystemFontOfSize:15]];
        [self.contentView addSubview:_mesageL];
        _dateL = [[UILabel alloc] initWithFrame:CGRectMake(_headerImage.right, _mesageL.top, self.contentView.width-_headerImage.right, WIDTH(15)) text:@"07-25" textColor:[UIColor lightGrayColor]  font:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:_dateL];
        self.numberL = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.width - 60-WIDTH(10), self.dateL.top, 60, WIDTH(15)) text:@"234" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:15]];
        self.numberL.textAlignment = NSTextAlignmentRight;
        //self.number.text = [NSString stringWithFormat:@"%@",_model.userName];
        [self.contentView addSubview:self.numberL];
        if (self.numberL.text.length != 0) {
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.numberL.text];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            [paragraphStyle setLineSpacing:5];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.numberL.text.length)];
            self.numberL.attributedText = attributedString;
            //调节高度
            CGSize size = CGSizeMake(MAXFLOAT, 20);
            CGSize labelSize = [self.numberL sizeThatFits:size];
            self.numberL.frame = CGRectMake(self.contentView.width - WIDTH(10) - labelSize.width, self.dateL.top ,labelSize.width, WIDTH(15));
        }
        
        self.personImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.numberL.left - self.numberL.height , self.numberL.top, self.numberL.height, self.numberL.height)];
        self.personImage.image = [UIImage imageNamed:@"eye"];
        [self.contentView addSubview:self.personImage];
        
    }
    
    return self;
}
@end
