//
//  LoginViewController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/12.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "PasswordRetrievalViewController.h"

/*  授权登录 */
#import "WXApi.h"
#define APP_ID          @"wx30ff9b844925f4ec"               //APPID
#define APP_SECRET      @"e8b005c4f0a8be416b0653fb1f434dbe" //appsecret

@interface LoginViewController ()<UITextFieldDelegate,UIAlertViewDelegate,TencentSessionDelegate>
{
    UITextField *nameTextField; // 用户名
    UITextField *codeTextField; // 密码
    UIButton *loginBtn;//登陆按钮
    UIButton *changePas;//修改密码
    UIButton *registerAccount;//注册账号
    UIButton *weixinBtn;//微信登陆
    UIButton *TencentBtn;//QQ登陆
    UIButton *weiboBtn;//微博登录
    UILabel *thirdParty;//第三方登陆Label
    
    
}
// QQ 授权实例变量
@property (nonatomic, strong) TencentOAuth *tencentOAuth ;
@property (nonatomic, strong) UIImageView *iconImage;
@end

@implementation LoginViewController
#pragma mark - 隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [nameTextField resignFirstResponder];
    [codeTextField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (nameTextField == textField|| codeTextField == textField ) {
        [textField resignFirstResponder];
    }
    return true;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self initTitleWith:@"登录"];
    //self.titleBackgroudView.backgroundColor = rgb(248, 14, 60);
    //[self addBackButtonWithTitle:@"返回"];
    self.line.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubView];
}

- (void)initSubView {
    _iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    _iconImage.frame = CGRectMake((kScreenWidth - WIDTH(65))/2, self.titleBackgroudView.bottom + WIDTH(5), WIDTH(65), WIDTH(65));
    [self.view addSubview: _iconImage];
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH(20), WIDTH(150), WIDTH(280), WIDTH(45)) text:nil placeholder:@"请输入账号" delegate:self];
    nameTextField.keyboardType = UIKeyboardTypeNumberPad;
    nameTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:nameTextField];
    
    codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(nameTextField.left, nameTextField.bottom+WIDTH(15), nameTextField.width, nameTextField.height) text:nil placeholder:@"请输入密码" delegate:self];
    codeTextField.secureTextEntry = YES;
    codeTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:codeTextField];
    
    UILabel *lineL = [[UILabel alloc] initWithFrame:CGRectMake(nameTextField.left, nameTextField.bottom+1, nameTextField.width, 1)];
    lineL.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineL];
    
    UILabel *lineL2 = [[UILabel alloc] initWithFrame:CGRectMake(codeTextField.left, codeTextField.bottom+1, codeTextField.width, 1)];
    lineL2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineL2];
    
    if ([self hasLogin]) {
        
        nameTextField.text = [USERDEFAULTS valueForKey:@"userName"];
        codeTextField.text = [USERDEFAULTS valueForKey:@"passWord"];
    }
    
    loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(codeTextField.left, codeTextField.bottom+WIDTH(40), codeTextField.width, codeTextField.height) title:@"登录" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:20] backgroundImageNames:nil target:self action:@selector(loginPush:)];
    loginBtn.backgroundColor = rgb(251, 163, 26);
    [self.view addSubview:loginBtn];
    
    changePas = [[UIButton alloc] initWithFrame:CGRectMake(loginBtn.right-WIDTH(100), loginBtn.bottom+WIDTH(10), WIDTH(100), WIDTH(20)) title:@"忘记密码?" textColor:[UIColor lightGrayColor] target:self action:@selector(changePush:)];
    changePas.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:changePas];
    //
    registerAccount = [[UIButton alloc] initWithFrame:CGRectMake(loginBtn.left, loginBtn.bottom+WIDTH(10), WIDTH(100), WIDTH(20)) title:@"注册" textColor:[UIColor orangeColor] target:self action:@selector(registerPush:)];
    registerAccount.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:registerAccount];
    
    /*
    UIButton *RegisterBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-43, TOP_BLANNER_HEIGHT-40, 40, 30) title:@"注册" textColor:[UIColor lightGrayColor] target:self action:@selector(clickRigster:)];
    RegisterBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.titleBackgroudView addSubview:RegisterBtn]; // 筛选按钮
    */
 
    thirdParty = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-130)/2, (kScreenHeight + self.titleBackgroudView.center.y)/2+WIDTH(150), 130, 25) text:@"其他登录方式" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:20]];
    thirdParty.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:thirdParty];
    UILabel *dottedLine = [[UILabel alloc] initWithFrame:CGRectMake(loginBtn.left, (kScreenHeight + self.titleBackgroudView.center.y)/2+WIDTH(150)+12.5, thirdParty.left-loginBtn.left, 1)];
    dottedLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:dottedLine];
    UILabel *dottedLineTwo = [[UILabel alloc] initWithFrame:CGRectMake(thirdParty.right, dottedLine.top, dottedLine.width, 1)];
    dottedLineTwo.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:dottedLineTwo];
    
    weixinBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH(45), thirdParty.bottom+WIDTH(20), WIDTH(45), WIDTH(45)) imageNames:@[@"微信图片",@"微信图片"] target:self action:@selector(clickWeixin:)];
    [self.view addSubview:weixinBtn];
    
    TencentBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-WIDTH(90), weixinBtn.top, weixinBtn.width, weixinBtn.height) imageNames:@[@"QQ图片",@"QQ图片"] target:self action:@selector(clickTencent:)];
    [self.view addSubview:TencentBtn];
    
    weiboBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth-WIDTH(45))/2, weixinBtn.top, weixinBtn.width, weixinBtn.height) imageNames:@[@"微博图片",@"微博图片"] target:self action:@selector(clickWeibo:)];
    [self.view addSubview:weiboBtn];
    
}
/*
 *登录按钮响应事件
 */
- (void)loginPush:(UIButton *)login {
    [self doBack];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    [Singleton shareSingleton].isLogin = YES;
    
    
    
    
    
    
    if ([self isBlankString:nameTextField.text] == YES || [self isBlankString:codeTextField.text] == YES) {
        [self showAlertViewWithMessage:@"用户名和密码不能为空哟"];
        //         [self showFailedView:@"用户名和密码不能为空哟"];
        return;
    }
    NSString *url = BX_URL;
    url = [url stringByAppendingFormat:@"/user/login.html"];
    // 参数：版本号、用户名、密码
    NSDictionary *params = @{@"v":@"",@"userName":nameTextField.text,@"password":codeTextField.text,@"from":@"drp"};
    
    // --Block 内部有用 self 的地方，全部替换 weakSelf 避免循环引用
    
    __weak typeof(self)weakSelf = self ;
    
    [HttpManager postJSONDataWithUrl:url params:params succss:^(id json) {
        if ([json[@"code"] isEqual:@0]) {
            NSDictionary *userDic = json[@"data"][@"user"];
            DLog(@"%@",userDic);
            BXKJUserInfo *userinfo = [[BXKJUserInfo alloc] initWithFields:userDic];
            
            [userinfo saveUserInfo];
            
            self.userInfo = [BXKJUserInfo getUserInfoFromCache];
            [USERDEFAULTS setValue:json[@"token"] forKey:@"token"];
            [USERDEFAULTS setValue:nameTextField.text forKey:@"userName"];
            [USERDEFAULTS setValue:codeTextField.text forKey:@"passWord"]; // 密码存入缓存
            [Singleton shareSingleton].isLogin = YES;
            [self doBack];
            
        } else if ([json[@"code"] isEqual: @6]){
            [self showAlertViewWithMessage:@"没有该用户"];
        }else if ([json[@"code"] isEqual:@7]){
            [self showAlertViewWithMessage:@"密码错误"] ;
        }else {
            [self showAlertViewWithMessage:@"系统未知错误，登录失败"];
        }
    } fail:^{
        
    }];
}
/*
 *修改密码响应事件
 */
- (void)changePush:(UIButton *)change {
    PasswordRetrievalViewController *retrieval = [PasswordRetrievalViewController new];
    [self goToController:retrieval withAnimation:YES];
    
}
/*
 *注册账号响应事件
 */
- (void)registerPush:(UIButton *)regisn {
    
    RegisterViewController *registerVC = [RegisterViewController new];
    [self goToController:registerVC withAnimation:YES];
    //[self presentViewController:registerVC animated:NO completion:nil];
}

/*
 *导航条注册账号响应事件
 */
/*
- (void)clickRigster:(UIButton *)click {
    
    RegisterViewController *registerVC = [RegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)hasLogin { // 进入程序时候，判断是否有账号密码
    
    NSString *name = [USERDEFAULTS valueForKey:@"userName"];
    NSString *pwd  = [USERDEFAULTS valueForKey:@"passWord"];
    
    if (name.length != 0 && pwd.length != 0) {
        return YES;
    } else {
        return NO;
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
//微信登陆
- (void)clickWeixin:(UIButton *)weiixin {
    DLog(@"w微信登录");
    // 判断是否安装微信
    if ([WXApi isWXAppInstalled]) {
        [self sendAuthRequest ];
        // 注册观察者，监听微信授权结果~
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WechatAuthResult:) name:@"WechatAuthResult" object:nil];
    }else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你尚未安装微信哟, 请安装后重试~" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertView show ];
    }
}

/**
 *  发送微信授权请求
 */
-(void)sendAuthRequest {
    
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init ];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"wx30ff9b844925f4ec" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

/**
 *  接收到微信授权结果，请求 access_token
 */
- (void) WechatAuthResult: (NSNotification *) notification {
    
    NSString *CODE = ((NSDictionary *)notification.userInfo)[@"code"] ;
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",APP_ID,APP_SECRET,CODE];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                [self getUserInfoWithAccess_token:dic[@"access_token"] Open_ID:dic[@"openid"]] ;
            }
        });
    });
}

/**
 *  通过 access_token 和 openId 获取用户信息
 */
-(void)getUserInfoWithAccess_token:(NSString *)accessToken Open_ID: (NSString *) openId {
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openId];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                DLog(@"nickname-------%@",dic[@"nickname"]);
                // 在此处请求服务器数据，然后通知登录成功，更改界面UI
                NSString *nickName = [NSString stringWithFormat:@"%@",dic[@"nickname"]];
                NSInteger sex = [dic[@"sex"] integerValue] ;
                NSString *headimgurl = [NSString stringWithFormat:@"%@",dic[@"headimgurl"]];
                NSString *unionid = [NSString stringWithFormat:@"%@",dic[@"unionid"]];
                NSInteger type = 1 ;
                [self getUserInforWithOAuthType:type NickName:nickName Sex:sex HeadImgUrl:headimgurl UnionId:unionid ];
            }
        });
    });
}
//QQ登陆
- (void)clickTencent:(UIButton *)tencent {
    DLog(@"QQ登陆");
    NSString *appid = @"1105350745" ;
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:appid andDelegate:self];
    
    NSArray* permissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO,nil];
    [ self.tencentOAuth authorize:permissions inSafari:NO];
}


/**
 *  QQ 授权登录成功代理
 */
- (void)tencentDidLogin {
    NSLog(@"登录成功~");
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length]){
        //  记录登录用户的OpenID、Token以及过期时间
        NSLog(@"accessToken--%@",self.tencentOAuth.accessToken);
        
        //   获取用户信息
        [self.tencentOAuth getUserInfo ];
        
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"QQ 授权登录失败~" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertView show ];
    }
}
/**
 *  QQ 授权登录，用户取消
 */
-(void)tencentDidNotLogin:(BOOL)cancelled {
    if (cancelled){
        NSLog(@"用户取消登录");
    }else{
        NSLog(@"登录失败");
    }
}
/**
 *  QQ 授权登录，没有网络~
 */
-(void)tencentDidNotNetWork {
    NSLog(@"无网络连接，请设置网络");
}
/**
 *  QQ 授权登录，获取用户信息~
 */
-(void)getUserInfoResponse:(APIResponse *)response {
    NSDictionary *dic = response.jsonResponse ;
    // 需要的数据~
    NSString *nickname = [NSString stringWithFormat:@"%@",dic[@"nickname"]];
    NSString *gender = [NSString stringWithFormat:@"%@",dic[@"gender"]];
    NSInteger sex ;
    if ([gender isEqualToString:@"男"]) {
        sex = 1 ;
    }else if ([gender isEqualToString:@"女"]){
        sex = 2 ;
    }
    NSString *headURL = [NSString stringWithFormat:@"%@",dic[@"figureurl_qq_2"]];
    NSString *unionid = [NSString stringWithFormat:@"%@",self.tencentOAuth.openId];
    NSInteger type = 2 ;
    [self getUserInforWithOAuthType:type NickName:nickname Sex:sex HeadImgUrl:headURL UnionId:unionid];
}


/**
 *  通过第三方授权获得的用户信息向服务器请求需要的数据
 */
- (void) getUserInforWithOAuthType: (NSInteger)type NickName: (NSString *)nickname Sex: (NSInteger) sex HeadImgUrl: (NSString *) headImgUrl UnionId: (NSString *)unionId {
    // 将昵称转换 UTF-8 形似
    nickname = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)nickname, nil, nil, kCFStringEncodingUTF8));
    NSString *url = BX_URL ;
    
    url = [url stringByAppendingString:@"/user/login/third.html"];
    NSDictionary *params = @{@"v":@"",@"nickName":nickname,@"sex":[NSString stringWithFormat:@"%ld",(long)sex],@"headImgUrl":headImgUrl,@"openId":unionId,@"type":[NSString stringWithFormat:@"%ld",(long)type],@"from":@"drp"};
    
    [HttpManager postJSONDataWithUrl:url params:params succss:^(id json) {
        if ([json[@"code"] isEqual:@0]) {
            
            NSDictionary *userDic = json[@"data"][@"user"];
            DLog(@"%@",userDic);
            BXKJUserInfo *userinfo = [[BXKJUserInfo alloc] initWithFields:userDic];
            
            [userinfo saveUserInfo];
            
            self.userInfo = [BXKJUserInfo getUserInfoFromCache];
            [USERDEFAULTS setValue:json[@"token"] forKey:@"token"];
            [USERDEFAULTS setValue:nameTextField.text forKey:@"userName"];
            [USERDEFAULTS setValue:codeTextField.text forKey:@"passWord"]; // 密码存入缓存
            [Singleton shareSingleton].isLogin = YES;
            //创建通知
            NSNotification *notification = [NSNotification notificationWithName:@"LoginSuccess" object:self userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [self doBack];
        }
    } fail:^{
        [self showAlertViewWithMessage:@"登录失败，请检查你的网络"];
    }];
    
}

//微博登陆
- (void)clickWeibo:(UIButton *)weibo {

}
@end
