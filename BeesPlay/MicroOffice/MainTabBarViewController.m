//
//  MainTabBarViewController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/12.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "BaseNavigationController.h"
#import "HomeImageViewController.h"
#import "NewsViewController.h"
#import "AlbumViewController.h"
#import "MineViewController.h"
#import "BroadcastViewController.h"
@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加子控制器
    [self addChildVc:[[HomeImageViewController alloc] init] title:@"首页" image:@"tabbar_icon_home_normal" selectedImage:@"tabbar_icon_home_highlight"];
    [self addChildVc:[[NewsViewController alloc] init] title:@"新闻" image:@"tabbar_icon_news_normal"selectedImage:@"tabbar_icon_news_highlight"];
    [self addChildVc:[[AlbumViewController alloc] init] title:@"专辑" image:@"tabbar_icon_album_normal" selectedImage:@"tabbar_icon_album_highlight"];
    [self addChildVc:[[BroadcastViewController alloc] init] title:@"直播" image:@"tabbar_icon_zhibo_normal" selectedImage:@"tabbar_icon_zhibo_highlight"];
    [self addChildVc:[[MineViewController alloc] init] title:@"我的" image:@"tabbar_icon_mine_normal" selectedImage:@"tabbar_icon_mine_highlight"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式rgb(248, 14, 60)
    
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName :kColor(123, 123, 123)} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName :rgb(248, 14, 60) } forState:UIControlStateSelected];
    //            childVc.view.backgroundColor = RandomColor; // 这句代码会自动加载主页，消息，发现，我四个控制器的view，但是view要在我们用的时候去提前加载
    
    // 为子控制器包装导航控制器
    BaseNavigationController  *navigationVc = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    // 添加子控制器
    [self addChildViewController:navigationVc];
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
