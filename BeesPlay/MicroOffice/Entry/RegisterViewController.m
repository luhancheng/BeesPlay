//
//  RegisterViewController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/13.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *account;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UITextField *determine;
@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, strong) UIButton *registerBtn;

@end

@implementation RegisterViewController

#pragma mark - 隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.account resignFirstResponder];
    [self.password resignFirstResponder];
    [self.determine resignFirstResponder];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.account == textField|| self.password == textField || self.determine == textField ) {
        [textField resignFirstResponder];
    }
    return true;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
   [self initTitleWith:@"注册账号"];

    //self.titleLabel.text = @"注册账号";//self.title = @""
    //self.titleLabel.textColor = [UIColor blueColor];
    self.titleBackgroudView.backgroundColor = rgb(255, 255, 255);
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBackButtonWithTitle:@"返回"];
    [self initSubViews];
    
}

- (void)initSubViews {
    self.account = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH(20), WIDTH(150), WIDTH(280), WIDTH(45)) text:nil placeholder:@"邮箱:" delegate:self];
    self.account.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.account];
    self.password = [[UITextField alloc] initWithFrame:CGRectMake(self.account.left, self.account.bottom+WIDTH(10), WIDTH(186), self.account.height) text:nil placeholder:@"请输入密码:" delegate:self];
    self.password.borderStyle = UITextBorderStyleNone;
    self.password.secureTextEntry = YES;
    [self.view addSubview:self.password];
    
  
    self.determine = [[UITextField alloc] initWithFrame:CGRectMake(self.password.left, self.password.bottom+WIDTH(10), self.account.width, self.password.height) text:nil placeholder:@"请再次输入密码:" delegate:self];
    self.determine.borderStyle = UITextBorderStyleNone;
    self.determine.secureTextEntry = YES;
    [self.view addSubview:self.determine];


    [self.view addSubview:self.codeBtn];

    self.registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.determine.left, self.determine.bottom+WIDTH(10), self.determine.width, self.determine.height) title:@"注册" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17] backgroundImageNames:nil target:self action:@selector(registerClick:)];
    self.registerBtn.backgroundColor = rgb(251, 163, 26);
    self.registerBtn.layer.cornerRadius = self.registerBtn.height/2;
    [self.view addSubview:self.registerBtn];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(self.account.left, self.account.bottom+1, self.account.width, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line1];
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(self.password.left, self.password.bottom+1, self.password.width, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line2];
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(self.determine.left, self.determine.bottom+1, self.determine.width, 1)];
    line3.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line3];
}

/*
 * 点击注册按钮
 */
- (void)registerClick:(UIButton *)registen {
    //邮箱格式判断待写
    if ([self isBlankString:self.account.text] == YES || [self isBlankString:self.password.text] == YES || [self isBlankString:self.determine.text] == YES) {
        [self showAlertViewWithMessage:@"内容不能为空呦"];
        return ;
    }
    /*
    // 拼接网络发送给服务器
    NSString *url = BX_URL ;
    url = [url stringByAppendingString:@"/reg/phonereg.html"];
   // NSDictionary *params = @{@"v":@"",@"phone":self.account.text,@"phoneCode":self.password.text,@"codeToken":codeToken,@"password":self.determine.text};
    
    [HttpManager postJSONDataWithUrl:url params:params succss:^(id json) {
        
        if ([json[@"code"] isEqual:@0]) {
            [[NSUserDefaults standardUserDefaults] setObject:self.account.text forKey:@"phone"];
            if (IOS8) {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"恭喜您，注册成功！" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    // 停掉定时器
                    [self stopTokenTimer];
                    // 退回页面
                    [self doBack];
                }];
                [alertC addAction:cancle];
                [alertC addAction:defult];
                [self presentViewController:alertC animated:YES completion:nil];
            }else {
                UIAlertView *alertV = [[UIAlertView alloc ] initWithTitle:@"恭喜您" message:@"注册成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                [alertV show];
                // 停掉定时器
                [self stopTokenTimer];
                // 退回页面
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }else if ([json[@"code"] isEqual:@4]){
            [self showAlertViewWithMessage:@"手机号码已被注册，请直接登录"];
        }else if ([json[@"code"] isEqual:@5]){
            [self showAlertViewWithMessage:@"验证码输入错误"];
        }else {
            [self showAlertViewWithMessage:@"系统错误，注册失败"];
        }
        
    } fail:^{
        [self showAlertViewWithMessage:@"注册失败，请检查您的网络"];
    }];
     */
    
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

