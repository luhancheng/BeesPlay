//
//  RegisterSuccessViewController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/15.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "RegisterSuccessViewController.h"
#import "LoginViewController.h"
@interface RegisterSuccessViewController ()
@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation RegisterSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.maskType == 5) {
        [self initTitleWith:@"找回密码"];
    } else {
        [self initTitleWith:@"注册账号"];
    }
   
    self.titleBackgroudView.backgroundColor = rgb(255, 255, 255);
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubView];
}
- (void)initSubView {
    _backImage= [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH(40), self.titleBackgroudView.bottom+WIDTH(40), kScreenWidth-WIDTH(80), kScreenHeight/2.5)];
    _backImage.image = [UIImage imageNamed:@"backGroup"];
    [self.view addSubview:_backImage];
    if (self.maskType == 5) {
        [_backImage setImage:[UIImage imageNamed:@"backGroupTwo"]];
    }
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(_backImage.left, _backImage.bottom+WIDTH(50), _backImage.width, WIDTH(45)) title:@"登录" textColor:[UIColor whiteColor] target:self action:@selector(loginClick:)];
    _loginBtn.backgroundColor = rgb(251, 163, 26);
    [self.view addSubview:_loginBtn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginClick:(UIButton *)login {
    LoginViewController *loginVC = [LoginViewController new];
    [self goToController:loginVC withAnimation:YES];

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
