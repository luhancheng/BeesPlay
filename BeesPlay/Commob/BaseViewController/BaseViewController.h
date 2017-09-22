//
//  BaseViewController.h
//  GoodProductOfHome
//
//  Created by 路瀚程的MacBook Pro on 16/5/12.
//  Copyright © 2016年 bxkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Toast+UIView.h"
#import "FailedView.h"
#import "UIImage+Color.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "BXKJUserInfo.h"
@interface BaseViewController : UIViewController
@property (nonatomic, strong) UIView *bgView;//红色背景
@property (nonatomic, strong) UIView *titleBackgroudView; // 导航栏
@property (nonatomic, strong) UILabel *titleLabel; // 标题Label,需初始化
@property (nonatomic, strong) UIButton *backButton; // 返回按钮

@property (nonatomic, assign) BOOL isloading; //是否正在加载
@property (nonatomic, assign) BOOL isCurrentController;
@property (nonatomic, assign) BOOL errorAlert;

//@property (nonatomic, strong) UIAlertView *alertSession; // session失效 alert，点击确定到登陆页面
//
//@property (nonatomic, strong) UIAlertView *alertView; // 错误提示 alert

@property (nonatomic, strong) NSDictionary *data;//http请求返回的数据

@property (nonatomic, strong) FailedView *failedView;  //加载错误视图


@property (nonatomic, strong) BXKJUserInfo *userInfo;

@property (nonatomic, strong) UILabel *line;


/**
 *  初始化导航栏标题
 *
 *  @param title 标题
 */
- (void )initTitleWith:(NSString *)title;
/**
 *  去掉多余的分割线
 *
 *  @param tableView 目标tableView
 */
- (void) setExtraCellLineHidden: (UITableView *)tableView;

/**
 *  加载错误页面
 *
 *  @param failString 错误信息提示
 */
- (void) showFailedView:(NSString *)failString;

/**
 *  加载错误信息第二种
 *
 *  @param message 错误信息提示
 */
-(void)showAlertViewWithMessage:(NSString *)message;

/**
 *  跳转页面
 *
 *  @param controller 目标Controller
 *  @param animation  是否动画
 */
- (void) goToController:(UIViewController *) controller withAnimation:(BOOL)animation;

/**
 *  添加返回按钮 和 标题
 *
 *  @param title 标题
 */
- (void)addBackButtonWithTitle:(NSString *)title;

//push返回
- (void) doBack;

//模态返回
- (void) doBackModel;

/**
 *  获取用户信息
 */

- (void)getUserInfo;
/**
 *  判断字符串为空
 */
- (BOOL) isBlankString:(NSString *)string;

@end
