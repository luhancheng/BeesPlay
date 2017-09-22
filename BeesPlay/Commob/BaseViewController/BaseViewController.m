//
//  BaseViewController.m
//  GoodProductOfHome
//
//  Created by 路瀚程的MacBook Pro on 16/5/12.
//  Copyright © 2016年 bxkj. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
@interface BaseViewController ()<FailedViewDelegate>

@end

@implementation BaseViewController

- (void)viewWillDisappear:(BOOL) animated {
    self.isCurrentController=NO;
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    self.isCurrentController=YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isloading = FALSE;
    _errorAlert = YES;
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    _bgView.backgroundColor = [UIColor clearColor];
    _bgView.hidden = YES;
    [self.view addSubview:_bgView];
    
    [self.view addSubview:self.titleBackgroudView];
    
    self.view.backgroundColor = kHexColor(@"efeff4");
    
}


- (UIView *)titleBackgroudView {
    if (_titleBackgroudView == nil) {
        _titleBackgroudView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, TOP_BLANNER_HEIGHT)];
        _titleBackgroudView.backgroundColor = [UIColor colorWithHexString:@"l" alpha:0.1];
        
        UIImageView *bgPic = [[UIImageView alloc] initWithFrame:_titleBackgroudView.frame];
        bgPic.image = [UIImage imageNamed:@"矩形-2@2x"];
        [_titleBackgroudView addSubview:bgPic];
        bgPic.alpha = 0.8;
        
        _line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleBackgroudView.frame)-1, kScreenWidth, 1)];
        _line.backgroundColor = kColor(230, 230, 230);
        [_titleBackgroudView addSubview:_line];
    }
    return _titleBackgroudView;
}

- (void)addBackButtonWithTitle:(NSString *)title {
    
    if (_backButton == nil) {
        
        _backButton= [[UIButton alloc] initWithFrame:CGRectMake(10, TOP_BLANNER_HEIGHT-44, 44, 44)];
        //        _backButton.backgroundColor = [UIColor redColor];/
        [_backButton addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
        _backButton.tag = 1;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 4, 30, 30)];
        imageView.image = [UIImage imageNamed:@"返回按钮-2"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [_backButton addSubview:imageView];
        
        [self.titleBackgroudView addSubview:_backButton];
        
    }
    //    _backButton.backgroundColor = [UIColor redColor];
    
}

- (void)initTitleWith:(NSString *)title {
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    _titleLabel.text = title;
    _titleLabel.numberOfLines = 1;
    _titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    if (title.length != 0) {
        CGRect rect = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20)//限制最大的宽度和高度
                                          options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                       attributes:@{NSFontAttributeName:_titleLabel.font}//传人的字体字典
                                          context:nil];
        _titleLabel.frame = CGRectMake(0, 0, rect.size.width, 20);
    }
    
    _titleLabel.center = CGPointMake(self.titleBackgroudView.center.x, TOP_BLANNER_HEIGHT-25);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    //_titleLabel.textColor = kHexColor(@"ffffff");
    _titleLabel.textColor = kHexColor(@"000000");
    [self.titleBackgroudView addSubview:_titleLabel];
}

- (BOOL)onclick:(UIButton *)sender {
    NSInteger btnTag = sender.tag;
    if(btnTag == 1){
        [self doBackModel];
        [self doBack];
        return YES;
    }else{
        
        [self doBack];
        return YES;
    }
    return NO;
}

- (void)doBack {
    
    _isloading = FALSE;
    if([SVProgressHUD isVisible]){
        [SVProgressHUD dismiss];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doBackModel {
    _isloading = FALSE;
    if([SVProgressHUD isVisible]){
        [SVProgressHUD dismiss];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    tableView.tableFooterView = [[UIView alloc]init];//关键语句
}

- (void)goToController:(UIViewController *) controller withAnimation:(BOOL)animation {
    
    [self.navigationController pushViewController:controller animated:animation];
}

- (void)showFailedView:(NSString *)failString {
    
    if (self.failedView) {
        [self.failedView hiddenFailedView];
        self.failedView = nil;
    }
    self.failedView = [[FailedView alloc] initWithErrorTitle:failString errorImageName:@""];
    self.failedView.delegate = self;
    [self.view addSubview:self.failedView];
}

-(void)showAlertViewWithMessage:(NSString *)message {
    if (IOS8) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertC addAction:defult];
        [self presentViewController:alertC animated:YES completion:nil];
    }else {
        UIAlertView *alertV = [[UIAlertView alloc ] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
    }

}

- (void)getUserInfo {
    
    self.userInfo = [BXKJUserInfo getUserInfoFromCache];
}

/**
 *  判断字符串为空
 */
- (BOOL) isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
#pragma mark - FailedViewDelegate

- (void)reloadDataClick {} // 错误信息重新请求，子类实现

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
