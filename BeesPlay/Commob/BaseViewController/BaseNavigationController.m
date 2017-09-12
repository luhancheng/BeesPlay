//
//  BaseNavigationController.m
//  GoodProductOfHome
//
//  Created by 路瀚程的MacBook Pro on 16/5/12.
//  Copyright © 2016年 bxkj. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setNavigationBarHidden:YES];
        //        self.navigationBar.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 20);
        //
        //        self.navigationBar.tintColor = [UIColor greenColor];
    }
    return self;
}


#pragma mark - BaseViewController里已经自定义导航条下面为另一种方式
//+ (void)initialize
//{// 只初始化一次
//    // 设置项目中item的主题样式
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//
//    // Normal
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
//    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//
//    // 不可用状态
//    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
//    disableTextAttrs[NSForegroundColorAttributeName] = kColor(123, 123, 123);
//    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
//    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
//}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 此时push进来的viewController是第二个子控制器
        // 进入子视图会自动隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
        
        //        // 定义leftBarButtonItem
        //        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTargat:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
        //
        //        // 定义rightBarButtonItem
        //        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTargat:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
    }
    // 调用父类pushViewController，self.viewControllers数组添加对象viewController
    [super pushViewController:viewController animated:animated];
}


//- (void)back
//{
//    // 这里要用self，不能用self.navigationViewController，因为self本身就是导航控制器对象，self.navigationViewController是nil
//    [self popViewControllerAnimated:YES];
//}
//
//- (void)more
//{
//    [self popToRootViewControllerAnimated:YES];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
