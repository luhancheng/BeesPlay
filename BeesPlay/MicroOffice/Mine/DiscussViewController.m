//
//  DiscussViewController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/28.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "DiscussViewController.h"

@interface DiscussViewController ()

@end

@implementation DiscussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTitleWith:@"讨论"];
    self.titleBackgroudView.backgroundColor = rgb(255, 255, 255);
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBackButtonWithTitle:@"返回"];
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
