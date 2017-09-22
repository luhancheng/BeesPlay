//
//  PasswordRetrievalViewController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/15.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "PasswordRetrievalViewController.h"
#import "RegisterSuccessViewController.h"
@interface PasswordRetrievalViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *account;
@property (nonatomic, strong) UIButton *sendBtn;
@end

@implementation PasswordRetrievalViewController
#pragma mark - 隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.account resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.account == textField) {
        [textField resignFirstResponder];
    }
    return true;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTitleWith:@"找回密码"];
    self.titleBackgroudView.backgroundColor = rgb(255, 255, 255);
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBackButtonWithTitle:@"返回"];
    
    [self initSubViews];
}
- (void)initSubViews {
    UILabel *emaiL = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH(20), WIDTH(130), WIDTH(135), WIDTH(45)) text:@"请输入邮箱号码:" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:16]];
    [self.view addSubview:emaiL];
    self.account = [[UITextField alloc] initWithFrame:CGRectMake(emaiL.right, emaiL.top, kScreenWidth-emaiL.right-emaiL.left, emaiL.height) text:nil placeholder:nil delegate:self];
    self.account.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.account];
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(emaiL.left, emaiL.bottom+1, self.account.right - emaiL.left, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line1];
    self.sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(emaiL.left, emaiL.bottom+WIDTH(25), self.account.right - emaiL.left, self.account.height) title:@"发送" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17] backgroundImageNames:nil target:self action:@selector(sendClick:)];
    self.sendBtn.backgroundColor = rgb(251, 163, 26);
    [self.view addSubview:self.sendBtn];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)sendClick:(UIButton *)sender {
    RegisterSuccessViewController *registerSVC = [RegisterSuccessViewController new];
    registerSVC.maskType = 5;
    [self goToController:registerSVC withAnimation:YES];
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
