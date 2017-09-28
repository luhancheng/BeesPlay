//
//  CollectionViewController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/26.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "CollectionViewController.h"
#import "AlbumCollectionController.h"
#import "ResourcesViewController.h"
@interface CollectionViewController ()<UIScrollViewDelegate>

{
    UIView *topView;
    
    UIButton *_topLeftBtn;
    UILabel *_centerLabel;
    UIButton *_topRightBtn;
    
    UIView *_lineView;
    
}

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) AlbumCollectionController *acVC;
@property (nonatomic,strong) ResourcesViewController *resourceVC;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.judgeType == 6) {
        [self initTitleWith:@"学习记录"];
    }else {
        [self initTitleWith:@"收藏"];
    }
    
    self.titleBackgroudView.backgroundColor = rgb(255, 255, 255);
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBackButtonWithTitle:@"返回"];
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-54, TOP_BLANNER_HEIGHT-44, 44, 44) imageNames:@[@"垃圾桶",@"垃圾桶"] target:self action:@selector(delete:)];
    [self.titleBackgroudView addSubview:saveBtn];
    [self initScrollView];
}
#pragma mark - 初始化视图

- (void)initScrollView {
    
    if (_scrollView) {
        for (UIView *subView in _scrollView.subviews) {
            [subView removeFromSuperview];
        }
    } else {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TOP_BLANNER_HEIGHT+49, kScreenWidth,kScreenHeight-TOP_BLANNER_HEIGHT-49)];
        _scrollView.contentSize = CGSizeMake(kScreenWidth*2, kScreenHeight-TOP_BLANNER_HEIGHT-49);
        _scrollView.scrollEnabled = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
    }
    _acVC = [[AlbumCollectionController alloc] init];
    _acVC.view.frame = CGRectMake(0, 0, kScreenWidth, _scrollView.height);
    [self addChildViewController:_acVC];
    [_scrollView addSubview:_acVC.view];
    
    _resourceVC = [[ResourcesViewController alloc] init];
    _resourceVC.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, _scrollView.height);
    [self addChildViewController:_resourceVC];
    [_scrollView addSubview:_resourceVC.view];

    _scrollView.contentOffset = CGPointMake(0, 0);
    [self initTopView];
}
- (void)initTopView {
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, TOP_BLANNER_HEIGHT, kScreenWidth, 49)];
    topView.backgroundColor = kHexColor(@"ffffff");
    [self.view addSubview:topView];
    
    _topLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2, topView.height) title:@"专辑" textColor:[UIColor orangeColor] target:self action:@selector(clickLeftBtn:)];
    _topLeftBtn.selected = YES;
    [_topLeftBtn setTitleColor:kHexColor(@"#333333") forState:UIControlStateNormal];
    [_topLeftBtn setTitleColor:kHexColor(@"#ff5500") forState:UIControlStateSelected];
    _topLeftBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [topView addSubview:_topLeftBtn];
    
    _centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(_topLeftBtn.right, 0, 1, topView.height) text:@"" textColor:nil font:[UIFont systemFontOfSize:15]];
    _centerLabel.backgroundColor =kHexColor(@"808080");
    [topView addSubview:_centerLabel];
    
    _topRightBtn = [[UIButton alloc] initWithFrame:CGRectOffset(_topLeftBtn.frame, kScreenWidth/2, 0) title:@"资源" textColor:[UIColor lightGrayColor] target:self action:@selector(clickRightBtn:)];
    _topRightBtn.selected = NO;
    [_topRightBtn setTitleColor:kHexColor(@"#333333") forState:UIControlStateNormal];
    [_topRightBtn setTitleColor:kHexColor(@"#ff5500") forState:UIControlStateSelected];
    _topRightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [topView addSubview:_topRightBtn];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, topView.height-2, 50, 2)];
    _lineView.backgroundColor = kHexColor(@"#ff5500");
    _lineView.center = CGPointMake(_topLeftBtn.center.x, _lineView.center.y);
    [topView addSubview:_lineView];
    
 
    
}

#pragma mark - 点击待办、已办、全部的方法

- (void)clickLeftBtn:(UIButton *)btn{
    
    _topLeftBtn.selected = YES;
    _topRightBtn.selected = NO;
    _scrollView.contentOffset = CGPointMake(0, 0);
    
    //    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [_acVC.tableView.mj_header beginRefreshing];
    
    [UIView animateWithDuration:0.1 animations:^{
        
        _lineView.frame = CGRectMake(0, topView.height-2, 50, 2);
        _lineView.center = CGPointMake(_topLeftBtn.center.x, _lineView.center.y);
        
    }];
}

- (void)clickRightBtn:(UIButton *)btn {
    
    _topLeftBtn.selected = NO;
    _topRightBtn.selected = YES;
    _scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    
    //    [_scrollView setContentOffset:CGPointMake(kScreenWidth*2, 0) animated:YES];
    
    [_resourceVC.tableView.mj_header beginRefreshing];
    
    [UIView animateWithDuration:0.1 animations:^{
        
        _lineView.frame = CGRectMake(kScreenWidth*2/3, topView.height-2, 50, 2);
        _lineView.center = CGPointMake(_topRightBtn.center.x, _lineView.center.y);
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)delete:(UIButton *)sender {
    
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

































