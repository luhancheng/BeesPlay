//
//  ResetPasswordViewController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/10/6.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UITextField *determine;
@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIView *hidenView;

@end

@implementation ResetPasswordViewController
#pragma mark - 隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.password resignFirstResponder];
    [self.determine resignFirstResponder];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.password == textField || self.determine == textField ) {
        [textField resignFirstResponder];
    }
    return true;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTitleWith:@"重置密码"];
    self.titleBackgroudView.backgroundColor = rgb(255, 255, 255);
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBackButtonWithTitle:@"返回"];
    [self initSubViews];
    [self hidenbackView];
   
}
- (void)initSubViews {
    UILabel *passwordL = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH(20), WIDTH(150), WIDTH(93), WIDTH(45)) text:@"请输入密码:" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:16]];
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
    
    self.registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(determinL.left, determinL.bottom+WIDTH(25), self.determine.right - determinL.left, self.determine.height) title:@"重置" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17] backgroundImageNames:nil target:self action:@selector(reset:)];
    self.registerBtn.backgroundColor = rgb(251, 163, 26);
    
    [self.view addSubview:self.registerBtn];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(passwordL.left, passwordL.bottom+1, self.password.right - passwordL.left, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line2];
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(determinL.left, determinL.bottom+1, self.determine.right - determinL.left, 1)];
    line3.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line3];
}

- (void)hidenbackView {
    _hidenView = [[UIView alloc] initWithFrame:CGRectMake(0, TOP_BLANNER_HEIGHT, kScreenWidth, kScreenHeight - TOP_BLANNER_HEIGHT)];
    _hidenView.hidden = YES;
    _hidenView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_hidenView];
    UIImageView *yesImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - WIDTH(22.5), WIDTH(120), WIDTH(45), WIDTH(45))];
    yesImage.image = [UIImage imageNamed:@"选中@3x"];
    [_hidenView addSubview:yesImage];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yesImage.bottom+WIDTH(10), kScreenWidth, 20) text:@"重置密码成功，请牢记您的新密码" textColor:[UIColor lightGrayColor]];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [_hidenView addSubview:textLabel];
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH(20), textLabel.bottom + WIDTH(20), kScreenWidth - WIDTH(40), WIDTH(45)) title:@"登录" textColor:[UIColor whiteColor] target:self action:@selector(login:)];
    loginBtn.backgroundColor = [UIColor orangeColor];
    [_hidenView addSubview:loginBtn];
}
/*
 * 点击登录按钮,一，是登录页面登录按钮的功能，二，跳转到登录页面重新登录，三，直接返回设置页面，先采用三
 */
- (void)login:(UIButton *)sender {
    [self doBack];

}



/*
 * 点击注册按钮
 */
- (void)reset:(UIButton *)registen {
  
    self.hidenView.hidden = NO;
    [self addBackButtonWithTitle:nil];
    
    
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
