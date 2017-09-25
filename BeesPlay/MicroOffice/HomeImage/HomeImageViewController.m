//
//  HomeImageViewController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/12.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "HomeImageViewController.h"
#import "LoginViewController.h"
#import "ClassificationController.h"
#import "TaskSearchController.h"
@interface HomeImageViewController ()

@end

@implementation HomeImageViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![Singleton shareSingleton].isLogin) {
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        //[self.navigationController presentViewController:loginVC animated:NO completion:nil];
        [self goToController:loginVC withAnimation:NO];
       
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setButtons];
}
#pragma mark - 初始化我的、筛选、搜索按钮

- (void)setButtons {
    
    UIButton *filterBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-43, TOP_BLANNER_HEIGHT-40, 30, 30) imageNames:@[@"filter@2x",@"filter@2x"] target:self action:@selector(clickFilterBtn)];
    [self.titleBackgroudView addSubview:filterBtn]; // 筛选按钮
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectOffset(filterBtn.frame, -43, 0) imageNames:@[@"search@2x",@"search@2x"] target:self action:@selector(clickSearchBtn)];
    [self.titleBackgroudView addSubview:searchBtn]; // 搜索按钮
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 按钮的点击方法
- (void) clickSearchBtn { // 搜索按钮
    TaskSearchController *searchVC = [[TaskSearchController alloc] init];
    [self goToController:searchVC withAnimation:YES];
}

- (void) clickFilterBtn { // 筛选按钮
    ClassificationController *chooseVC = [[ClassificationController alloc] init];
    [self goToController:chooseVC withAnimation:YES];
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
