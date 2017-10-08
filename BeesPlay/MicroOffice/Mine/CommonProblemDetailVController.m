//
//  CommonProblemDetailVController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/10/5.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "CommonProblemDetailVController.h"

@interface CommonProblemDetailVController ()

@end

@implementation CommonProblemDetailVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self addBackButtonWithTitle:@"返回"];
    [self initSobView];
}

- (void)initSobView {
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *detailL = [[UILabel alloc] initWithFrame:CGRectMake(0, TOP_BLANNER_HEIGHT, kScreenWidth, 50) text:@"如何添加信息"];
    detailL.layer.borderColor = [[UIColor grayColor] CGColor];
    detailL.layer.borderWidth = 0.5f;
    detailL.layer.masksToBounds = YES;
    [self.view addSubview:detailL];
    UILabel *textL = [[UILabel alloc] initWithFrame:CGRectMake(detailL.left, detailL.bottom, detailL.width, detailL.height * 2) text:@"用户将鼠标点击到下拉框，添加文字，表情，重要信息即可" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:15]];
    
//    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
//    CGSize labelSize = [textL.text boundingRectWithSize:CGSizeMake(kScreenWidth, kScreenHeight) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
//    textL.frame = CGRectMake(textL.frame.origin.x, textL.frame.origin.y, textL.frame.size.width, labelSize.height);
    

    [self.view addSubview:textL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
