//
//  NoteViewController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/28.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "NoteViewController.h"

@interface NoteViewController ()

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleWith:@"笔记"];
    self.titleBackgroudView.backgroundColor = rgb(255, 255, 255);
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBackButtonWithTitle:@"返回"];
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-54, TOP_BLANNER_HEIGHT-44, 44, 44) imageNames:@[@"垃圾桶",@"垃圾桶"] target:self action:@selector(delete:)];
    [self.titleBackgroudView addSubview:saveBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)delete:(id)sender {
    DLog(@"删除");
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
