//
//  RegisterViewController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/13.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterSuccessViewController.h"
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
    self.titleBackgroudView.backgroundColor = rgb(255, 255, 255);
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBackButtonWithTitle:@"返回"];
    
    [self initSubViews];
    
}

- (void)initSubViews {
    UILabel *emaiL = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH(20), WIDTH(150), WIDTH(45), WIDTH(45)) text:@"邮箱:" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:16]];
    [self.view addSubview:emaiL];
    self.account = [[UITextField alloc] initWithFrame:CGRectMake(emaiL.right, emaiL.top, kScreenWidth-emaiL.right-emaiL.left, emaiL.height) text:nil placeholder:nil delegate:self];
    self.account.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.account];
    UILabel *passwordL = [[UILabel alloc] initWithFrame:CGRectMake(emaiL.x, emaiL.bottom+WIDTH(10), WIDTH(93), WIDTH(45)) text:@"请输入密码:" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:16]];
    [self.view addSubview:passwordL];
    self.password = [[UITextField alloc] initWithFrame:CGRectMake(passwordL.right, passwordL.top, kScreenWidth - passwordL.right-passwordL.left, passwordL.height) text:nil placeholder:nil delegate:self];
    self.password.borderStyle = UITextBorderStyleNone;
    self.password.secureTextEntry = YES;
    [self.view addSubview:self.password];
    
    UILabel *determinL = [[UILabel alloc] initWithFrame:CGRectMake(passwordL.x, passwordL.bottom+WIDTH(10), WIDTH(135), WIDTH(45)) text:@"请再次输入密码:" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:16]];
    [self.view addSubview:determinL];
    self.determine = [[UITextField alloc] initWithFrame:CGRectMake(determinL.right, determinL.top, kScreenWidth - determinL.right-determinL.left, determinL.height) text:nil placeholder:nil delegate:self];
    self.determine.borderStyle = UITextBorderStyleNone;
    self.determine.secureTextEntry = YES;
    [self.view addSubview:self.determine];


    [self.view addSubview:self.codeBtn];

    self.registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(determinL.left, determinL.bottom+WIDTH(25), self.determine.right - determinL.left, self.determine.height) title:@"注册" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17] backgroundImageNames:nil target:self action:@selector(registerClick:)];
    self.registerBtn.backgroundColor = rgb(251, 163, 26);

    [self.view addSubview:self.registerBtn];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(emaiL.left, emaiL.bottom+1, self.account.right - emaiL.left, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line1];
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(passwordL.left, passwordL.bottom+1, self.password.right - passwordL.left, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line2];
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(determinL.left, determinL.bottom+1, self.determine.right - determinL.left, 1)];
    line3.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line3];
}

/*
 * 点击注册按钮
 */
- (void)registerClick:(UIButton *)registen {
    RegisterSuccessViewController *registerSuc = [RegisterSuccessViewController new];
    [self goToController:registerSuc withAnimation:YES];
    //邮箱格式判断
    if ([self isValidateEmail:self.account.text] ==NO) {
        [UIAlertController alertControllerWithTitle:@"邮箱格式错误" message:nil preferredStyle:UIAlertControllerStyleAlert];
    }
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

//手机号码的正则表达式
- (BOOL)isValidateMobile:(NSString *)mobile{
    //手机号以13、15、18开头，八个\d数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//邮箱地址的正则表达式
- (BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
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

